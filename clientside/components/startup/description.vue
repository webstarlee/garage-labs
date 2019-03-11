<template>
    <div class=" panel panel-default">
        <div v-if="loading" class="text-center" style="padding: 200px 0">
            <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
        </div>
        <div v-if="!loading">
            <div class="panel-heading grid-panel-title" style="display:flex;">
                 <div class="panel-startup-logo" style="margin-right:15px;" v-bind:style="{'background-image': data.logo ? getBackgroundImage(data.logo_url) : ''}">
                    <img v-if="!data.logo" src="/vendor/img/startup-logo.jpg" alt="">
                </div>
                <div class="panel-startup-title">
                    <h1 class="title-shot">{{ data.title | capitalize }}</h1>
                    <div class="account-wrapper">
                        <img src="/vendor/img/startup-page-icons/author.png" >
                        <span class="btn-block subtitle-shot col-thumb">By
                            <router-link v-bind:to="`/users/${ data.author_id }`">{{ data.author.first_name }} {{ data.author.last_name }}</router-link>
                            <span class="ic-sep">|</span>
                            <template v-if="auth && user.id === data.author_id">
                                <router-link v-bind:to="`/startups/${ data.slug }/edit`">Editer</router-link>
                            </template>
                        </span>
                    </div>
                </div>
                
            </div>
            <div class="panel-body startup-details">

                <div class=" btn-block pull-left text-left">
                    <img src="/vendor/img/custom-icon/ic-tag-16.png" width="16">
                    <span class="subtitle-section">{{startupDetailConfig.category}}</span> 
                    <div class="section-description">
                      <span style="margin-right: 5px;" v-for="category in data.categories" v-bind:key="category.id">{{ category.name }}, </span> 
                    </div>
                </div>
                
                <div class=" btn-block pull-left text-left">
                    <img src="/vendor/img/custom-icon/ic-coworker.png" width="16">
                    <span class="subtitle-section">{{startupDetailConfig.research}}</span> 
                    <div class="section-description">
                      {{ data.findingNames }}
                    </div>
                </div>
                
                <div class=" btn-block pull-left text-left">
                    <img src="/vendor/img/custom-icon/ic-light-bulb2.png" width="16">
                    <span class="subtitle-section">{{startupDetailConfig.concept}}</span> 
                    <div class="section-description">
                      {{data.concept}}
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                    <img src="/vendor/img/custom-icon/ic-tactics.png" width="16">
                    <span class="subtitle-section">{{startupDetailConfig.business_model}}</span> 
                    <div class="section-description">
                      {{data.business_model}}
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                    <img src="/vendor/img/custom-icon/badge.png" width="16">
                    <span class="subtitle-section">{{startupDetailConfig.competitor}}</span> 
                    <div class="section-description">
                      {{data.competitors}}
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                 <img src="/vendor/img/custom-icon/ic-line-chart.png" width="16">
                    <span class="subtitle-section">{{startupDetailConfig.avancement}}</span> 
                    <div class="project-status" style="padding-left: 29px;">
                    <div class="project-status-option">
                        <span class="ns-icon ns-icon-16">
                            <img v-if="data.selected_p_status[0]" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            {{startupDetailConfig.avancement_checkbox[0]}}
                        </span>
                    </div>
                    <div class="project-status-option">
                        <span class="ns-icon ns-icon-16">
                            <img v-if="data.selected_p_status[1]" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            {{startupDetailConfig.avancement_checkbox[1]}}
                        </span>
                    </div>
                    <div class="project-status-option">
                     <span class="ns-icon ns-icon-16">
                            <img v-if="data.selected_p_status[2]" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            {{startupDetailConfig.avancement_checkbox[2]}}
                        </span>
                    </div>
                    <div class="project-status-option">
                     <span class="ns-icon ns-icon-16">
                            <img v-if="data.selected_p_status[3]" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            {{startupDetailConfig.avancement_checkbox[3]}}
                        </span>
                     
                    </div>
                    <div class="project-status-option">
                     <span class="ns-icon ns-icon-16">
                            <img v-if="data.selected_p_status[4]" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            {{startupDetailConfig.avancement_checkbox[4]}}
                        </span>
                    </div>
                </div>
                </div>
                
                <!-- <p class="advance-section"><span class="subtitle-section">Avancement</span> </p>
                 -->
                
                 <div class="btn-block pull-left text-left skill-wrapper">
                    <img src="/vendor/img/custom-icon/ic-settings2.png" width="16">
                    <span class="subtitle-section">{{startupDetailConfig.skill}}</span> 
                    <div class="section-description">
                      <ul>
                          <li  v-for="skill in data.skills" v-bind:key="skill.id">{{skill.name}}</li>
                      </ul>
                    </div>
                </div>
                 <div class="btn-block pull-left text-left">
                  <img src="/vendor/img/custom-icon/ic-info.png" width="16">
                    <span class="subtitle-section">{{startupDetailConfig.profile_looking}}</span> 
                    <div class="section-description">
                        {{data.looking_partners}}
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                 <img src="/vendor/img/custom-icon/ic-world-web.png" width="16">
                   <span class="subtitle-section">{{startupDetailConfig.website}}</span> 
                    <div class="section-description">
                        {{data.website}}
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                 <img src="" width="16">
                   <span class="subtitle-section">{{startupDetailConfig.video}}</span> 
                    <div class="section-description">
                        {{data.concept_video}}
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                 <img src="" width="16">
                   <span class="subtitle-section">{{startupDetailConfig.fundraising}}</span> 
                    <div class="section-description" v-if="data.fonds_type">
                        <p>{{data.fonds_type.name}}</p>
                        <p>{{startupDetailConfig.amount_research}}: {{data.montant_recherche}}€</p>
                        <p>{{startupDetailConfig.shares_ceded}}: {{data.parts_sociales_cedees}}%</p>
                        <p>{{startupDetailConfig.valorization_society}}: {{data.valorisation_societe}}€</p>
                        <p>{{startupDetailConfig.amounts_raised}}: {{data.montant_leve}}</p>
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                 <img src="" width="16">
                   <span class="subtitle-section">{{startupDetailConfig.fundraising_exploitation}}</span> 
                    <div class="section-description">
                       <p>{{data.montant_utilisation}}</p>
                    </div>
                </div>
                <div class="btn-block pull-left text-left">
                 <img src="" width="16">
                   <span class="subtitle-section">{{startupDetailConfig.team}}</span> 
                    <div class="section-description">
                        <div class="team-members row">

                            <div v-for="member in data.teams" class="team-member col-md-3 text-center">
                                <div class="member-picture">
                                    <img v-if="!member.info || !member.info.avatar_path" v-bind:src="member.avatar_path" alt="">
                                    <img v-if="member.info && member.info.avatar_path" v-bind:src="member.info.avatar_path" alt="">
                                </div>
                                <div class="member-name">
                                    <p v-if="!member.info || !member.info.first_name || !member.info.last_name">{{member.name}}</p> 
                                    <p v-if="member.info && member.info.first_name && member.info.last_name">{{member.info.first_name}}  {{member.info.last_name}}</p> 
                                </div>
                                <ul class="list-inline member-title">
                                    <li>
                                        <router-link v-if="member.active === 1" v-bind:to="`/users/${member.user_id}`">{{member.role}}</router-link>
                                        <p v-if="member.active !== 1">{{member.role}}</p>
                                    </li>
                                     <li>
                                        <a href="" v-on:click.prevent="showEditMemberModal(member)" v-if="isOwner">
                                            <img src="/vendor/img/custom-icon/ic-pencil.png" width="14px" height="14px"/>
                                        </a> 
                                     </li>
                                     
                                </ul>
                                <div class="member-role">
                                    {{member.description}}
                                </div>
                            </div>
                            
                            <div class="add-member col-md-3 text-center" v-if="isOwner">
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
                                        <p>{{startupDetailConfig.add_member}}</p>
                                    </div>
                                </a>
                            </div>
                            <div id="editMemberModal"
                                 class="modal fade editedMemberModal"
                                 tabindex="-1"
                                 role="dialog"
                                 aria-labelledby="myModalLabel"
                                 aria-hidden="true" >

                                <div class="modal-dialog">
                                    <div class="modal-content">

                                        <div class="modal-header">

                                            Edit a member
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Fermer</span></button>
                                           
                                        </div>

                                        <div class="modal-body" v-if="isOwner">

                                            <div class="memberName text-center">{{editedMember.name}}</div>
                                            <div class="memberDate">
                                                <p>Invited on {{editedMember.created_at | moment("Do MMMM YYYY")}} ({{editedMember.email}})</p>
                                                 <p>Joined on {{editedMember.joined_at  ? (editedMember.joined_at) : 'N/A'}}</p>
                                            </div>
                                            <form v-on:submit.prevent="editTeamMember(editedMember)">
                                                    <div class="member-name">
                                                         <input v-bind:value="editedMember.name" type="text" name="member_title" class="form-control input-sm" placeholder="Member title (ex: CTO)" disabled>
                                                    </div> 
                                                    <div class="member-title">
                                                         <input  v-model="editedMember.role" type="text" name="member_role" class="form-control input-sm" >
                                                    </div>
                                                     <div class="member-title">
                                                         <input  v-model="editedMember.description"  type="text" name="member_description" class="form-control input-sm" >
                                                    </div>

                                                     <div class="member-add">
                                                        <button class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">Update</button>
                                                    </div>                
                                            </form>
                                            <a v-if="editedMember.user_id !== data.author_id" href="javascript:void(0)" v-on:click.prevent="deleteTeamMember(editedMember)">Delete member</a>
                                        </div>
                                    </div>
                                 </div>
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
                                                         <input v-model="newMember.role" type="text" name="member_role" class="form-control input-sm" placeholder="Member title (ex: CTO)">
                                                        <p v-if="errors.role !== undefined" class="help-block">{{ errors.role.join() }}</p>
                                                    </div>
                                                    <div class="member-title" v-bind:class="{ 'has-error': errors.email !== undefined && errors.email.length }">
                                                         <input v-model="newMember.email" type="email" name="member_email" class="form-control input-sm" placeholder="email">
                                                        <p v-if="errors.email !== undefined" class="help-block">{{ errors.email.join() }}</p>
                                                    </div>
                                                    <div class="member-role" v-bind:class="{ 'has-error': errors.description !== undefined && errors.description.length }">
                                                         <textarea v-model="newMember.description" style="height: 70px;resize: none;" placeholder="Say few words about his/her role in the startup" class="form-control input-sm"
                                                        ></textarea>
                                                        <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                                    </div>
                                                    <div class="member-add">
                                                        <button class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">Invit</button>
                                                    </div>                                               
                                                    <div v-if="submitting" class="text-center" style="padding: 10px 0">
                                                        <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
                                                    </div>
                                            </form>
                                        </div>
                                    </div>
                                 </div>
                            </div>


                        </div>
                    </div>
                </div>
                <div class="contact-wrapper">
                        <div class="contact-text">Contacts({{data.num_contacts}})</div>
                        <div class="contact-button" v-if="auth && data.author_id !== user.id">
                            <button class="ns-btn ns-btn-yel" style="width:250px;" data-toggle="modal" data-target="#chatModal">
                                <template>    
                                    I am interested in this project
                                </template>
                            </button>
                        </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>

   
   
   
    export default {
        data(){
            return {
                newMember: {
                    role:'',
                    description:'',
                    email: ''
                },
                editedMember: {},
                errors: {},
                startupDetailConfig: {}
            }
        },
        props: ['data', 'loading'],
        created() {
            this.fetchContentEn();
        },
        computed: {
            auth() {
                return this.$store.getters.auth;

            },
            user() {
                return this.$store.getters.user;
            },
            isOwner() {
                return this.auth && this.data.author_id === this.user.id;
            }
        },
        methods: {
            fetch(){

                this.$http.get(`/api/startups/${this.data.slug}`).then(response => {
                        this.data = response.data;
                });

            },
            showEditMemberModal(member){
                    this.editedMember = member;
                    this.editedMember.email = member.email
                    this.editedMember.role = member.role
                    this.editedMember.description = member.description;
                    $("#editMemberModal").modal('show');
                    
            },
            editTeamMember(member){
                    var _data = {};
                    _data.role = member.role;
                    _data.description = member.description;
                    _data.start_up_id = member.start_up_id;
                    _data.user_id = member.user_id;
                    this.$http.post('/api/team/editMember', _data).then(response => {
                         

                    }).finally(()=>{
                         $("#editMemberModal").modal('hide');
                         _data = {};
                         this.editedMember = {};
                         this.fetch();

                     });
            },
            deleteTeamMember(member){
                 var _data = {};
                    _data.role = member.role;
                    _data.description = member.description;
                    _data.start_up_id = member.start_up_id;
                    _data.user_id = member.user_id;
                    _data.email = member.email;

                    this.$http.post('/api/team/deleteMember', _data).then(response => {
                    },
                    response => {
                        alert(response.body.message);
                    }
                    ).finally(()=>{
                         $("#editMemberModal").modal('hide');
                         _data = {};
                         this.editedMember = {};
                         this.fetch();
                    });
            },
             addTeamMember() {
                var _new = {};
                if (this.existingMember(this.newMember.email)) {
                    alert('Member already existed!!!');
                    return;
                }

                this.submitting = true;
                this.errors = {};
                _new.user_id = 0;
                _new.startup_id = this.data.id;
                _new.name = 'New member'; 
                _new.role = this.newMember.role;
                _new.description = this.newMember.description;
                _new.link = this.randomString();
                _new.avatar_path = '/vendor/img/startup-logo.jpg';
                _new.active = 0;
                _new.email = this.newMember.email;;

                this.$http.post('/api/team/addMember', _new).then(response => {
                    this.data.teams.push(response.data);
                    this.newMember = {};
                    $("#addMemberModal").modal('hide');
                }, response => {
                this.errors = response.body;
                
                }).then(() => {
                    this.submitting = false;
                });
            },
             existingMember(email) {
                if (!this.data.teams || !email) {
                    return false;
                }

                var existing = false;
                var teams = this.data.teams;
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
            getBackgroundImage(path) {
                return `url(${path})`;
            },
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.startupDetailConfig = response.body.startup_detail;
                }, response => {
                    console.log(response);
                });
            }
        }
    }
    
</script>


<style>
    .startup-details .team-members .team-member .member-name > p ,
    .startup-details .team-members .add-member .member-name > p,
    .startup-details .team-members .team-member .member-title {
        padding: 0px;
        margin: 0px;
        line-height: 14px;
    }
    .startup-details .team-members .team-member .member-name{
        margin-bottom:3px;
    }
    
    .startup-details .team-members .member-role {
        font-size: 13px;
        color:#5f5f5f;
    }

    .panel-startup-logo {
        width: 58px;
        height: 59px;
        background-size: cover;
        background-position: center;
    }
</style>