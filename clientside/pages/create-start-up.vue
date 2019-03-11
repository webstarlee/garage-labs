<template>
    <div class="content-wrapper">
        <div class="jumbotron static-header">
            <div class="container wrap-jumbotron">
                <h1 class="title-item none-overflow">
                    <router-link to="/" class="link-home">
                        <i class="glyphicon glyphicon-home myicon-right"></i> <i class="fa fa-angle-right"></i>
                    </router-link> {{startupConfig.title}}
                </h1>
            </div>
        </div>
        <div class="container wrap-ui">
            <div class="row">
                <div class="col-md-offset-2 col-md-8">
                    <div class="panel panel-default startup">
                        <div class="panel-heading grid-panel-title text-center">
                            <div class="btn-block">
                                <span v-bind:class="{ active: stage === 1 }" class="nav-span">
                                    <span class="badge">1</span>{{startupConfig.step1}}
                                </span>
                                <i class="fa fa-angle-right" style="margin: 0px 15px 0px 15px;"></i>
                                <span v-bind:class="{ active: stage === 2 }" class="nav-span">
                                    <span class="badge">2</span> {{startupConfig.step2}}
                                </span>
                                <i class="fa fa-angle-right" style="margin: 0px 15px 0px 15px;"></i>
                                <span v-bind:class="{ active: stage === 3 }" class="nav-span">
                                    <span class="badge">3</span> {{startupConfig.step3}}
                                </span>
                            </div>
                        </div>
                        <div v-show="stage === 1" class="panel-body">
                            <form v-on:submit.prevent="moveForward()" class="form-horizontal form-account" role="form">
                                <fieldset v-bind:disabled="loading">
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.title !== undefined && errors.title.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_title}}
                                        </label>
                                        <div class="col-sm-10">
                                            <input v-model="startup.title" type="text" name="title" class="form-control input-sm" placeholder="Nom du projet ou de la start-up">
                                            <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                        </div>
                                    </div>

                                    <!-- **** form-group **** -->
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.categories !== undefined && errors.categories.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_category}}</label>
                                        <div class="col-sm-10">
                                            <div id="categories-bloc">
                                                <select v-for="startup_category in startup.categories"
                                                        v-model="startup_category.id"
                                                        v-bind:key="startup_category.id"
                                                        class="input-sm"
                                                        style="margin-bottom: 10px"
                                                >
                                                    <option v-for="category in categories" v-bind:value="category.id" v-bind:key="category.id">{{ category.name }}</option>
                                                </select>
                                                <p v-if="errors.categories !== undefined" class="help-block">{{ errors.categories.join() }}</p>
                                            </div>
                                            + <a href="javascript:void(0)" @click="addCategory()"><u>{{startupConfig.form_add_more_categories}}</u></a>
                                        </div>
                                        
                                    </div>

                                    <div class="form-group" v-bind:class="{ 'has-error': errors.finding !== undefined && errors.finding.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_researcher}} (<i class="noted-text">{{startupConfig.form_at_least_one}}</i>)</label>
                                        <div class="col-sm-10 finding-wrapper">
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="0" v-model="startup.finding"  id="finding1" />
                                                <label for="finding1">{{startupConfig.step1_checkbox[0]}}</label>
                                            </div>
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="1" v-model="startup.finding" id="finding2" />
                                                <label for="finding2">{{startupConfig.step1_checkbox[1]}}</label>
                                            </div>

                                            <p v-if="errors.finding !== undefined" class="help-block">{{ errors.finding.join() }}</p>
                                        </div>
                                    </div>

                                        <!-- _version2 -->
                                    <div v-show="startup.finding.indexOf('1')>=0" class="form-group">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_researcher_fund}}</label>
                                        <div class="col-sm-10">
                                            <div id="rechercheFonds-bloc1">
                                                <select v-model="startup.fonds_types_id"
                                                        class="input-sm" 
                                                        style="margin-bottom: 10px">
                                                    <option v-for="type in fonds" v-bind:value="type.id">{{type.name}}</option>
                                                </select> 
                                            </div>

                                            <div id="rechercheFonds-bloc2" class="row">
                                                <div class="col-sm-3">
                                                    <input v-model="startup.montant_recherche" type="text" name="montant_recherche" class="form-control input-sm" placeholder="Montant recherché (€)">
                                                </div>
                                                <div class="col-sm-3">
                                                    <input v-model="startup.parts_sociales_cedees" type="text" name="parts_sociales_cedes" class="form-control input-sm" placeholder="Parts sociales cédés (%)">
                                                </div>
                                                <div class="col-sm-3">
                                                    <input v-model="startup.valorisation_societe" type="text" name="valorisation_societe" class="form-control input-sm" placeholder="Valorisation de la société (€)">
                                                </div>
                                                <div class="col-sm-3">
                                                    <input v-model="startup.montant_leve" type="text" name="montant_leve" class="form-control input-sm" placeholder="Montant déjà levé (€)">
                                                </div>
                                            </div>

                                            <div id="rechercheFonds-bloc3" style="margin-top: 10px;">
                                                <textarea
                                                    v-model="startup.montant_utilisation" class="form-control input-sm"
                                                    style="height: 100px;resize: none;"
                                                    placeholder="Pour quelle utilisation souhaitez lever ce montant? (monter un MVP, recruter des ressources commerciales, scaler,..)"
                                                ></textarea>
                                            </div>
                                            
                                        </div>

                                        
                                    </div>



                                    <div class="form-group" v-bind:class="{ 'has-error': errors.concept !== undefined && errors.concept.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_concept}}</label>
                                        <div class="col-sm-10">
                                            <textarea v-model="startup.concept"
                                                    class="form-control input-sm"
                                                    style="height: 100px;resize: none;"
                                                    v-bind:placeholder="startupConfig.form_concept"
                                            ></textarea>
                                            <p v-if="errors.concept !== undefined" class="help-block">{{ errors.concept.join() }}</p>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.business_model !== undefined && errors.business_model.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_business_model}}</label>
                                        <div class="col-sm-10">
                                            <textarea v-model="startup.business_model"
                                                    class="form-control input-sm"
                                                    style="height: 100px;resize: none;"
                                                    v-bind:placeholder="startupConfig.form_business_model"
                                            ></textarea>
                                            <p v-if="errors.business_model !== undefined" class="help-block">{{ errors.business_model.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.competitors !== undefined && errors.competitors.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_competitor}}</label>
                                        <div class="col-sm-10">
                                            <textarea v-model="startup.competitors"
                                                    class="form-control input-sm"
                                                    style="height: 100px;resize: none;"
                                                    placeholder="Avez-vous des concurrents ? \n Si oui, citez-les"
                                            >
                                            </textarea>
                                            <p v-if="errors.competitors !== undefined" class="help-block">{{ errors.competitors.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.logo !== undefined && errors.logo.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_logo}}</label>
                                        <div class="col-sm-10">
                                            <input type="file" @change="uploadAttachment($event)" class="up_0">
                                            <p v-if="errors.logo !== undefined" class="help-block">{{ errors.logo.join() }}</p>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                        <div v-show="stage === 2" class="panel-body">
                            <div class="row">
                                <div class="title text-center">
                                    <h2>{{startupConfig.step2_title}}</h2>
                                </div>
                            </div>
                            <div class="team-members row">

                                <div v-for="(member, index) in startup.team" class="team-member col-md-4">
                                    <div class="member-picture">
                                        <img v-if="!member.avatar_path" src="/vendor/img/startup-logo.jpg" alt="">
                                        <img v-if="member.avatar_path" v-bind:src="member.avatar_path" alt="">
                                    </div>
                                    <div class="member-name">
                                        <p>{{member.name}}</p>
                                    </div>
                                    <div class="member-title">
                                        <input v-model="member.role" type="text" name="member_title" class="form-control input-sm" placeholder="Member title (ex: CTO)" >
                                        <p v-if="member.error" style="color:red;">This field is required.</p>
                                    </div>
                                    <div class="member-role">
                                        <textarea v-model="member.description" style="height: 70px;resize: none;" placeholder="Say few words about your role in the startup" class="form-control input-sm"
                                        ></textarea>
                                    </div>
                                    <div>
                                        <a v-if="member.active !== 1" href="javascript:void(0)" v-on:click="removeMember(index)">Delete</a>
                                    </div>
                                </div>
                            

                    
                                <div class="add-member col-md-4">
                                    <a href=""
                                    v-on:click.prevent
                                    title="Ajouter un membre title btn"
                                        data-error="Une erreur a été rencontrée"
                                        data-send="Envoyer le message"
                                        data-wait="Envoi en cours..."
                                        data-success="Envoyé avec succès"
                                        data-id="1"
                                        data-toggle="modal"
                                        data-target="#addMemberModal">
                                        <div class="member-picture">
                                        <img src="/vendor/img/startup-page-icons/add-member.png" alt="">
                                        </div>
                                        <div class="member-name">
                                            <p>{{startupConfig.form_add_member}}</p>
                                        </div>
                                    </a>
                                </div>

                                <div id="addMemberModal"
                                    class="modal fade"
                                    tabindex="-1"
                                    role="dialog"
                                    aria-labelledby="myModalLabel"
                                    aria-hidden="true" >

                                    <div class="modal-dialog">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Fermer</span></button>
                                            
                                            </div>

                                            <div class="modal-body text-left">
                                                <form v-on:submit.prevent="addTeamMember()" v-bind:disabled="submitting">
                                                
                                                        <div class="member-title" v-bind:class="{ 'has-error': errors.role !== undefined && errors.role.length }">
                                                            <label for="member_title">Role :</label>
                                                            <input v-model="newMember.role" id="member_title" type="text" name="member_title" class="form-control input-sm" placeholder="Member title (ex: CTO)">
                                                            <p v-if="errors.role !== undefined" class="help-block">{{ errors.role.join() }}</p>
                                                        </div>
                                                        <div class="member-title" v-bind:class="{ 'has-error': errors.email !== undefined && errors.email.length }">
                                                            <label for="member_email">Email :</label>
                                                            <input v-model="newMember.email" id="member_email" type="email" name="member_email" class="form-control input-sm" placeholder="email">
                                                            <p v-if="errors.email !== undefined" class="help-block">{{ errors.email.join() }}</p>
                                                        </div>
                                                        <div class="member-role" v-bind:class="{ 'has-error': errors.description !== undefined && errors.description.length }">
                                                            <label for="member_desc">Description :</label>
                                                            <textarea id="member_desc" v-model="newMember.description" style="height: 70px;resize: none;" placeholder="Say few words about his/her role in the startup" class="form-control input-sm"
                                                            ></textarea>
                                                            <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                                        </div>
                                                        <div class="member-add">
                                                            <button class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">Invit</button>
                                                        </div>                                               
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div v-show="stage === 3" class="panel-body">
                            <form v-on:submit.prevent="moveForward()" class="form-horizontal form-account" role="form">
                                <fieldset v-bind:disabled="loading">
                                    <!-- **** form-group **** -->
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.project_status !== undefined && errors.project_status.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_project_status}} (<i class="noted-text">{{startupConfig.form_at_least_one}}</i>)</label>
                                        <div class="col-sm-10 finding-wrapper">
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="0" v-model="startup.project_status"  id="status1" />
                                                <label for="status1">{{startupConfig.step3_checkbox[0]}}</label>
                                            </div>
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="1" v-model="startup.project_status" id="status2" />
                                                <label for="status2">{{startupConfig.step3_checkbox[1]}}</label>
                                            </div>
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="2" v-model="startup.project_status" id="status3" />
                                                <label for="status3">{{startupConfig.step3_checkbox[2]}}</label>
                                            </div>
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="3" v-model="startup.project_status" id="status4" />
                                                <label for="status4">{{startupConfig.step3_checkbox[3]}}</label>
                                            </div>
                                            <div class="checkbox-wrapper">
                                                <input type="checkbox" value="4" v-model="startup.project_status" id="status5" />
                                                <label for="status5">{{startupConfig.step3_checkbox[4]}}</label>
                                            </div>
                                            <p v-if="errors.project_status !== undefined" class="help-block">{{ errors.project_status.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.skills !== undefined && errors.skills.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_skill}}</label>
                                        <div class="col-sm-10">
                                            <div id="categories-bloc">
                                                <select v-for="startup_skills in startup.skills"
                                                        v-model="startup_skills.id"
                                                        v-bind:key="startup_skills.id"
                                                        class="input-sm"
                                                        style="margin-bottom: 10px"
                                                >
                                                    <option v-for="skill in skills" v-bind:value="skill.id" v-bind:key="skill.id">{{ skill.name }}</option>
                                                </select>
                                                <p v-if="errors.skills !== undefined" class="help-block">{{ errors.skills.join() }}</p>
                                            </div>
                                            + <a href="javascript:void(0)" @click="addSkill()"><u>{{startupConfig.form_add_more_skills}}</u></a>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.looking_partners !== undefined && errors.looking_partners.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_partner}}</label>
                                        <div class="col-sm-10">
                                            <textarea v-model="startup.looking_partners"
                                                    class="form-control input-sm"
                                                    style="height: 100px;resize: none;"
                                                    placeholder="Dites en plus sur le/les associés que vous recherchez"
                                            ></textarea>
                                            <p v-if="errors.looking_partners !== undefined" class="help-block">{{ errors.looking_partners.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.website !== undefined && errors.website.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_website}}</label>
                                        <div class="col-sm-10">
                                            <input v-model="startup.website" type="text" name="website" class="form-control input-sm" placeholder="Site internet">
                                            <p v-if="errors.website !== undefined" class="help-block">{{ errors.website.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.concept_video !== undefined && errors.concept_video.length }">
                                        <label class="col-sm-2 control-label input-sm">{{startupConfig.form_video_url}}</label>
                                        <div class="col-sm-10">
                                            <input v-model="startup.concept_video" type="text" name="concept_video" class="form-control input-sm" placeholder="Vidéo du concept">
                                            <p v-if="errors.concept_video !== undefined" class="help-block">{{ errors.concept_video.join() }}</p>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>

                        <div class="form-group panel-body mb-0 text-center">
                            <div class="col-sm-offset-2 col-sm-10 pl-0">
                                <div v-if="submitting" class="text-center" style="padding: 200px 0">
                                    <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
                                </div>
                                    <div v-if="loading" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></div>
                                    <button @click="moveForward()" class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">
                                    <template v-if="stage == 1 || stage == 2">
                                        {{startupConfig.form_next_button}}
                                    </template>
                                    <template v-else>
                                        {{startupConfig.form_submit_button}}
                                    </template>
                                </button>
                                <a href="javascript:void(0)" @click="moveBack()" class="ns-btn btn-inverse" style="width:150px;">
                                    {{startupConfig.form_back_button}}
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <ad></ad>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import ad from '../components/ad.vue';
    import typeahead from '../components/typeahead.vue';

    export default {
        data() {
            return {
                stage: 1,
                newMember: {
                    role:'',
                    description:'',
                    email: ''
                },
                categories: [],
                skills: [],
                fonds:[],
                loading: true,
                startup: {
                    title: '',
                    categories: [],
                    finding: [],
                    team: [],
                    fonds_types_id:0,
                    montant_recherche: '',
                    parts_sociales_cedees: '',
                    valorisation_societe: '',
                    montant_leve: '',
                    montant_utilisation: '',
                    concept: '',
                    business_model: '',
                    competitors: '',
                    project_status: [],
                    looking_partners: '',
                    website: '',
                    concept_video: '',
                    skills: [],
                    logo: ''
                },
                errors: [],
                submitting: false,
                defaultOwnRole: 'My position (Ex. CEO)',
                defaultOwnDesc: 'Say some words about you role in the company.',
                startupConfig: {}
            }
        },
        created() {
            this.fetchFonds();
            this.fetchCategories();
            this.fetchSkills();
            this.addCategory();
            this.addSkill();
            this.addOwnerToTeam();

            if (this.$route.query.type==='investisseur') {
                this.startup.finding.push('1');
            }

            this.fetchContentEn();
        },
        computed: {
            user() {
                return this.$store.getters.user;
            }
        },
        methods: {
            fetchFonds(){
                 this.$http.get('/api/fonds').then(response => {
                    this.fonds = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            fetchCategories() {
                this.$http.get('/api/categories/startups').then(response => {
                    this.categories = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            fetchSkills() {
                this.$http.get('/api/skills').then(response => {
                    this.skills = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            checkstartupFirstRequest() {
                this.errors = {};
                this.loading = true;

                return this.$http.post('/api/startups/check-1', this.startup);
            },
            addCategory() {
                this.startup.categories.push({});
            },
            addSkill() {
                this.startup.skills.push({});
            },
            moveForward() {
                this.loading = true;
                if(this.stage === 1) {
                    this.checkstartupFirstRequest().then(response => {
                        this.stage += 1;
                    }, response => {
                        this.errors = response.data;
                    }).finally(() => {
                        this.loading = false;
                    });
                }
                if(this.stage === 2) {
                    if (this.validateMember ()) {
                        this.stage += 1;
                    }
                    
                    this.loading = false;
                    return;
                }

                if(this.stage === 3) {
                    this.$http.post('/api/startups/create', this.startup).then(response => {
                        this.$router.push(`/startups/${ response.body.slug }`);
                    }, response => {
                        this.errors = response.data;
                    }).finally(() => {
                        this.loading = false;
                    });
                }
            },
            validateMember() {
                let isValid = true;
                var numMems = this.startup.team.length;
                for (var i = 0; i < numMems; i++) {
                    this.startup.team[i].error = false;
                    
                    if (this.startup.team[i].description === this.defaultOwnDesc) {
                        this.startup.team[i].description = null;
                    }

                    if (!this.startup.team[i].role 
                    || this.startup.team[i].role.trim().length === 0 
                    || this.startup.team[i].role === this.defaultOwnRole) {
                        this.startup.team[i].error = true;
                        isValid = false;
                    }
                }

                return isValid;
            },
            moveBack() {
                if (this.stage == 1) {
                    this.$router.push('/?type=startups');
                } else {
                    this.stage -= 1;
                }
            },
            addTeamMember() {
                var _new = {};
                if (this.existingMember(this.newMember.email)) {
                    alert('Member already existed!!!');
                    return;
                }

                this.submitting = true;
                this.loading = true;

                this.errors = {};
                this.$http.post('/api/startups/invite', this.newMember).then(response => {
                    _new.role = this.newMember.role;
                    _new.description = this.newMember.description;
                    _new.email = this.newMember.email;
                    _new.link = this.randomString();
                    _new.active = 0;

                    if (response.data.id) {
                        _new.user_id = response.data.id;
                        _new.name = response.data.first_name + ' ' + response.data.last_name; 
                        _new.avatar_path = response.data.avatar_path;
                        
                    } else {
                        _new.user_id = 0;
                        _new.name = 'New member';
                        _new.avatar_path = '/vendor/img/startup-logo.jpg';
                    }

                    _new.error = false;
                    this.startup.team.push(_new);
                    _new = {};
                    this.newMember = {};
                    $("#addMemberModal").modal('hide');
            }, response => {
               this.errors = response.body;
               
            }).then(() => {
                this.submitting = false;
                this.loading = false;
            });
            },
            addOwnerToTeam() {
                var member = {
                    name: this.user.first_name + ' ' + this.user.last_name,
                    role: this.defaultOwnRole,
                    description: this.defaultOwnDesc,
                    avatar_path: this.user.avatar_path,
                    link: '',
                    email: this.user.email,
                    user_id: this.user.id,
                    active: 1,
                    error: false
                }
                
                this.startup.team.push(member);
            },
            existingMember(email) {
                if (!this.startup.team) {
                    return false;
                }

                var existing = false;
                var teams = this.startup.team;
                for(var i = 0; i < teams.length; i++) {
                    if (teams[i].email.toUpperCase() === email.toUpperCase()) {
                        existing = true;
                        break;
                    }
                }

                return existing;
            },
            randomString(length = 20) {
                var text = "";
                var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

                for (var i = 0; i < length; i++) {
                    text += possible.charAt(Math.floor(Math.random() * possible.length));
                }
                   
                return text;
            },
            removeMember(index) {
                if (index !== 0 && this.startup.team && this.startup.team.length > index) {
                    this.startup.team.splice(index, 1);
                }
            },
             uploadAttachment(event) {
                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('logo', file);
                this.loading = true;

                this.$http.post('/api/startups/logo/upload', data).then(response => {
                    this.startup.logo = response.data.logo;
                }, response => {
                    alert(response.body.logo.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
                })
            },
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.startupConfig = response.body.create_startup;
                }, response => {
                    console.log(response);
                });
            }
        },
        components: {
            ad,
            typeahead
        }
    }
</script>

<style>
    .team-members {
        display: flex;
        flex-flow: wrap;
    }
    .team-members .team-member,
    .team-members .add-member{
        padding: 10px;
        margin-bottom: 20px;
    }
    .team-members .team-member .member-picture,
    .team-members .add-member .member-picture{
        text-align: center;
        margin-bottom: 6px;
    }
    .team-members .team-member .member-picture > img,
    .team-members .add-member .member-picture > img {
        border-radius: 50%;
        height:60px;
        width:60px;
    }
    .team-members .team-member .member-name ,
    .team-members .add-member .member-name {
        text-align: center;
    }
    .team-members .team-member .member-title {
        margin-bottom: 10px;
    }
    .team-members .team-member .member-role textarea {
        font-size: 1em;
    }

    #addMemberModal .member-title,
    #addMemberModal .member-role {
        margin-bottom: 1em;
    }
    #addMemberModal .member-add{
        margin-top:1em;
    }

</style>