<template>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <div class="col-md-8">
                <div v-if="loading" class="text-center" style="padding: 50px">
                    <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
                </div>
                <div v-if="! loading && found === true" class="panel panel-default startup">
                    <div class="panel-heading grid-panel-title">
                        <div class="btn-block">
                            <h4>Edit the start-up</h4>
                        </div>
                    </div>
                    <div class="panel-body">
                        <form v-on:submit.prevent="update()" class="form-horizontal form-account">
                        <fieldset v-bind:disabled="updating">
                            <div class="form-group" v-bind:class="{ 'has-error': errors.title !== undefined && errors.title.length }">
                                <label class="col-sm-2 control-label input-sm">Title
                                </label>
                                <div class="col-sm-10">
                                    <input v-model="startup.title" type="text" name="title" class="form-control input-sm" placeholder="Nom du projet ou de la start-up">
                                    <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                </div>
                            </div>
                            <!-- **** form-group **** -->
                            <div class="form-group" v-bind:class="{ 'has-error': errors.categories !== undefined && errors.categories.length }">
                                <label class="col-sm-2 control-label input-sm">Categories</label>
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
                                    + <a href="javascript:void(0)" @click="addCategory()"><u>Add category</u></a>
                                </div>
                            </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.finding_ids !== undefined && errors.finding_ids.length }">
                                <label class="col-sm-2 control-label input-sm">I research (<i class="noted-text">At least one</i>)</label>
                                <div class="col-sm-10 finding-wrapper">
                                    <div class="checkbox-wrapper">
                                        <input type="checkbox" value="0" v-model="startup.finding_ids"  id="finding1" />
                                        <label for="finding1">One or more associates</label>
                                    </div>
                                    <div class="checkbox-wrapper">
                                        <input type="checkbox" value="1" v-model="startup.finding_ids" id="finding2" />
                                        <label for="finding2">A investor</label>
                                    </div>

                                    <p v-if="errors.finding_ids !== undefined" class="help-block">{{ errors.finding_ids.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.concept !== undefined && errors.concept.length }">
                                <label class="col-sm-2 control-label input-sm">The concept</label>
                                <div class="col-sm-10">
                                    <textarea v-model="startup.concept"
                                                class="form-control input-sm"
                                                style="height: 100px;resize: none;"
                                                placeholder="Le concept"
                                    ></textarea>
                                    <p v-if="errors.concept !== undefined" class="help-block">{{ errors.concept.join() }}</p>
                                </div>
                            </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.business_model !== undefined && errors.business_model.length }">
                                <label class="col-sm-2 control-label input-sm">The business model</label>
                                <div class="col-sm-10">
                                    <textarea v-model="startup.business_model"
                                                class="form-control input-sm"
                                                style="height: 100px;resize: none;"
                                                placeholder="Le business model"
                                    ></textarea>
                                    <p v-if="errors.business_model !== undefined" class="help-block">{{ errors.business_model.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.competitors !== undefined && errors.competitors.length }">
                                <label class="col-sm-2 control-label input-sm">Concurrents</label>
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
                             <div class="form-group" v-bind:class="{ 'has-error': errors.project_status_ids !== undefined && errors.project_status_ids.length }">
                                <label class="col-sm-2 control-label input-sm">Status of the project (<i class="noted-text">At least one</i>)</label>
                                <div class="col-sm-10 finding-wrapper">
                                    <div class="checkbox-wrapper">
                                        <input type="checkbox" value="0" v-model="startup.project_status_ids"  id="status1" />
                                        <label for="status1">Idea</label>
                                    </div>
                                    <div class="checkbox-wrapper">
                                        <input type="checkbox" value="1" v-model="startup.project_status_ids" id="status2" />
                                        <label for="status2">Business plan / model made</label>
                                    </div>
                                    <div class="checkbox-wrapper">
                                        <input type="checkbox" value="2" v-model="startup.project_status_ids" id="status3" />
                                        <label for="status3">Produit/MVP existant</label>
                                    </div>
                                    <div class="checkbox-wrapper">
                                        <input type="checkbox" value="3" v-model="startup.project_status_ids" id="status4" />
                                        <label for="status4">First customers / proof of viability</label>
                                    </div>
                                        <div class="checkbox-wrapper">
                                        <input type="checkbox" value="4" v-model="startup.project_status_ids" id="status5" />
                                        <label for="status5">Table tower (s) posted</label>
                                    </div>
                                    <p v-if="errors.project_status_ids !== undefined" class="help-block">{{ errors.project_status_ids.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.skills !== undefined && errors.skills.length }">
                                <label class="col-sm-2 control-label input-sm">Skills sought</label>
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
                                    + <a href="javascript:void(0)" @click="addSkill()"><u>Add a skill</u></a>
                                </div>
                            </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.looking_partners !== undefined && errors.looking_partners.length }">
                                <label class="col-sm-2 control-label input-sm">associates</label>
                                <div class="col-sm-10">
                                    <textarea v-model="startup.looking_partners"
                                                class="form-control input-sm"
                                                style="height: 100px;resize: none;"
                                                placeholder="Tell more about the partner (s) you are looking for"
                                    ></textarea>
                                    <p v-if="errors.looking_partners !== undefined" class="help-block">{{ errors.looking_partners.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.website !== undefined && errors.website.length }">
                                <label class="col-sm-2 control-label input-sm">Site internet</label>
                                <div class="col-sm-10">
                                    <input v-model="startup.website" type="text" name="website" class="form-control input-sm" placeholder="Site internet">
                                    <p v-if="errors.website !== undefined" class="help-block">{{ errors.website.join() }}</p>
                                </div>
                            </div>
                                <div class="form-group" v-bind:class="{ 'has-error': errors.concept_video !== undefined && errors.concept_video.length }">
                                <label class="col-sm-2 control-label input-sm">Video URL</label>
                                <div class="col-sm-10">
                                    <input v-model="startup.concept_video" type="text" name="concept_video" class="form-control input-sm" placeholder="Vidéo du concept">
                                    <p v-if="errors.concept_video !== undefined" class="help-block">{{ errors.concept_video.join() }}</p>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-block btn-primary">Update</button>
                        </fieldset>
                    </form>
                    </div>
                </div>
                <div v-if="! loading && found === false" class="panel panel-default startup">
                    <div class="panel-heading">
                        <h3>The page you are looking for does not exist.</h3>
                    </div>
                    <div class="panel-body">
                        The requested page is not available.
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import typeahead from '../components/typeahead.vue';

    export default {
        data() {
            return {
                found: null,
                loading: true,
                updating: false,
                startup: {},
                errors: {},
                categories: [],
                skills: []
            }
        },
        created() {
            setTimeout(() => {
                this.fetch();
                this.fetchCategories();
                this.fetchSkills();
            }, 0);
        },
        components: {
            typeahead: typeahead
        },
        methods: {
            update() {
                this.updating = true;
                this.errors = {};

                this.$http.post(`/api/startups/${ this.$route.params.id }/update`, this.startup).then(response => {
                    alert('Update start-up successfully!!');
                }, errors => {
                    this.errors = errors.body;
                    alert('Failed to update startup.');
                }).finally(() => {
                    this.updating = false;
                });
            },
            fetch() {
                this.$http.get(`/api/startups/${ this.$route.params.id }`).then(response => {
                    this.startup = response.data;
                    this.found = true;
                }, response => {
                    if(response.status === 404) {
                        this.found = false;
                    }
                    console.log(response);
                }).then(() => {
                    this.loading = false;
                });
            },
            addCategory() {
                this.startup.categories.push({});
            },
            addSkill() {
                this.startup.skills.push({});
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
            }
        }
    }
</script>