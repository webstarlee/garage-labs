<template>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <div class="col-md-8">
                <div v-if="loading" class="text-center" style="padding: 50px">
                    <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
                </div>
                <div v-if="! loading && found === true" class="panel panel-default project">
                    <div class="panel-heading grid-panel-title">
                        <div class="btn-block">
                            <h4>Editer le projet</h4>
                        </div>
                    </div>
                    <div class="panel-body">
                        <form v-on:submit.prevent="update()" class="form-horizontal form-account">
                        <fieldset v-bind:disabled="updating">
                            <div class="form-group">
                                <label class="col-sm-2 control-label input-sm">Type</label>
                                <div class="col-sm-10">
                                    <div style="float:left">
                                        <div class="picker picker-radio ">
                                            <div class="picker-handle">
                                                <div class="picker-flag"></div>
                                            </div>
                                        </div>
                                        <input type="radio"
                                               id="project_type"
                                               v-model="project.type"
                                               v-bind:value="'project'"
                                               style="margin:0.3em 0.3em 0 0; float:left"
                                               class="picker-element"
                                               name="project-type"
                                        ><label for="project_type">Projet</label>
                                    </div>
                                    <div style="float:left; margin-left:10px">
                                        <div class="picker picker-radio ">
                                            <div class="picker-handle">
                                                <div class="picker-flag"></div>
                                            </div>
                                        </div>
                                        <input type="radio"
                                               id="mission_type"
                                               v-model="project.type"
                                               v-bind:value="'mission'"
                                               style="margin:0.3em 0.3em 0 0; float:left"
                                               class="picker-element"
                                               name="project-type"
                                        ><label for="mission_type">Mission</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.title !== undefined && errors.title.length }">
                                <label class="col-sm-2 control-label input-sm">Title
                                </label>
                                <div class="col-sm-10">
                                    <input v-model="project.title" type="text" name="job_title" class="form-control input-sm" placeholder="Title of project">
                                    <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.categories !== undefined && errors.categories.length }">
                                <label class="col-sm-2 control-label input-sm">Categories</label>
                                <div class="col-sm-10">
                                    <div id="categories-bloc">
                                        <select v-for="project_category in project.categories"
                                                v-model="project_category.id"
                                                class="input-sm"
                                                style="margin-bottom: 10px"
                                        >
                                            <option v-for="category in categories" v-bind:value="category.id">{{ category.name }}</option>
                                        </select>
                                        <p v-if="errors.categories !== undefined" class="help-block">{{ errors.categories.join() }}</p>
                                    </div>
                                    + <a href="javascript:void(0)" @click="addCategory()"><u>Ajouter une catégorie</u></a>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.description !== undefined && errors.description.length }">
                                <label class="col-sm-2 control-label input-sm">Description</label>
                                <div class="col-sm-10">
                                            <textarea v-model="project.description"
                                                      class="form-control input-sm"
                                                      style="height: 100px"
                                            ></textarea>
                                    <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.tags !== undefined && errors.tags.length }">
                                <label class="col-sm-2 control-label input-sm">Compétences/<br>Technologies</label>
                                <div class="col-sm-10">
                                    <typeahead v-on:selected="addTag"
                                               :src="'/api/tags/search'"
                                               :createUrl="'/api/tags'"
                                               :queryParam="'keyword'"
                                    ></typeahead>
                                    <div style="margin-bottom: 10px;">
                                        <button type="button"
                                                v-for="(tag, index) in project.tags"
                                                @click="removeTag(index)"
                                                class="btn btn-xs btn-inverse"
                                                style="margin-right: 5px; margin-top: 5px;"
                                        >
                                            {{ tag.name }}
                                        </button>
                                    </div>
                                    <p v-if="errors.tags !== undefined" class="help-block">{{ errors.tags }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.budget !== undefined && errors.budget.length }">
                                <label class="col-sm-2 control-label input-sm">Budget (€) *</label>
                                <div class="col-sm-10">
                                    <input v-model="project.budget" type="text" class="form-control input-sm">
                                    <p v-if="errors.budget !== undefined" class="help-block">{{ errors.budget.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.starts_at !== undefined && errors.starts_at.length }">
                                <label for="starts-at" class="col-sm-2 control-label input-sm">Date de début *</label>
                                <div class="col-sm-10">
                                    <div class="input-group input-group-sm">
                                        <input id="starts-at"
                                               type="text"
                                               v-model="project.starts_at"
                                               v-datepicker="setStartsAt"
                                               class="form-control input-sm"
                                        />
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                    </div>
                                    <div class="clearfix"></div>
                                    <p v-if="errors.starts_at !== undefined" class="help-block">{{ errors.starts_at.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.ends_at !== undefined && errors.ends_at.length }">
                                <label for="ends_at" class="col-sm-2 control-label input-sm">Date de fin</label>
                                <div class="col-sm-10">
                                    <div class="input-group input-group-sm">
                                        <input id="ends_at"
                                               v-model="project.ends_at"
                                               type="text"
                                               class="form-control input-sm"
                                               v-datepicker="setEndsAt"
                                        />
                                                <span class="input-group-addon">
                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                </span>
                                    </div>
                                    <div class="clearfix"></div>
                                    <p v-if="errors.ends_at !== undefined" class="help-block">{{ errors.ends_at.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label input-sm">Pièces jointes</label>
                                <div class="col-sm-10">
                                    + <a href="javascript:void(0)" @click="project.attachments.push({})"><u>Ajouter un document (jpeg, png, doc(x), ppt(x), pdf, xls, csv, txt)</u></a>
                                </div>
                            </div>
                            <div v-for="(attachment, index) in project.attachments" class="form-group mb-0">
                                <div class="col-sm-10 col-sm-offset-2">
                                    <div id="upload_inputs">
                                        <div class="col-sm-5 pl-0">
                                            <input type="file" @change="uploadAttachment(attachment, $event, index)" class="up_0">
                                            <p class="help-block"></p>
                                        </div>
                                        <div class="col-sm-5">
                                            <a id="up_0"
                                               @click="project.attachments.splice(index, 1)"
                                               style="padding: 5px 10px;"
                                               class="delete_up pull-right btn btn-inverse btn-sm"
                                               value="remove"
                                            >X</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.contact_phone !== undefined && errors.contact_phone.length }">
                                <label class="col-sm-2 control-label input-sm">Contact téléphonique
                                </label>
                                <div class="col-sm-10">
                                    <input type="text"
                                           v-model="project.contact_phone"
                                           class="form-control input-sm"
                                           placeholder="Contact phone"
                                    >
                                    <p v-if="errors.contact_phone !== undefined" class="help-block">{{ errors.contact_phone.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group" v-bind:class="{ 'has-error': errors.contact_email !== undefined && errors.contact_email.length }">
                                <label class="col-sm-2 control-label input-sm">Contact email
                                </label>
                                <div class="col-sm-10">
                                    <input type="text"
                                           v-model="project.contact_email"
                                           class="form-control input-sm"
                                           placeholder="Contact email"
                                    >
                                    <p v-if="errors.contact_email !== undefined" class="help-block">{{ errors.contact_email.join() }}</p>
                                </div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-2 control-label input-sm">Je souhaite être contacté</label>
                                <div class="col-sm-10">
                                    <div style="float:left">
                                        <div class="picker picker-radio ">
                                            <div class="picker-handle">
                                                <div class="picker-flag"></div>
                                            </div>
                                        </div>
                                        <input v-model="project.show_phone"
                                               id="contact_phone"
                                               type="checkbox"
                                               style="margin:0.5em 0.3em 0 0; float:left"
                                               class="picker-element"
                                        /> <label for="contact_phone">Par téléphone</label>
                                    </div>
                                    <div style="float:left; margin-left:10px">
                                        <div class="picker picker-radio ">
                                            <div class="picker-handle">
                                                <div class="picker-flag"></div>
                                            </div>
                                        </div>
                                        <input v-model="project.show_email"
                                               id="contact_email"
                                               type="checkbox"
                                               style="margin:0.5em 0.3em 0 0; float:left"
                                               class="picker-element"
                                        > <label for="contact_email">Par email</label>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-block btn-primary">Mettre à jour</button>
                        </fieldset>
                    </form>
                    </div>
                </div>
                <div v-if="! loading && found === false" class="panel panel-default project">
                    <div class="panel-heading">
                        <h3>La page demandée n'existe pas.</h3>
                    </div>
                    <div class="panel-body">
                        La page demandée n'est pas disponible.
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
                uploading: false,
                project: {},
                errors: {},
                categories: []
            }
        },
        created() {
            setTimeout(() => {
                this.fetch();
                this.fetchCategories();
            }, 0);
        },
        components: {
            typeahead: typeahead
        },
        methods: {
            update() {
                this.updating = true;
                this.errors = {};

                this.$http.post(`/api/projects/${ this.$route.params.id }/update`, this.project).then(response => {
                    console.log(response);
                }, errors => {
                    this.errors = errors.body;
                }).finally(() => {
                    this.updating = false;
                });
            },
            fetch() {
                this.$http.get(`/api/projects/${ this.$route.params.id }`).then(response => {
                    this.project = response.data;
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
                this.project.categories.push({});
            },
            fetchCategories() {
                this.$http.get('/api/categories').then(response => {
                    this.categories = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            addTag(tag) {
                let found = false;

                for(let i = 0; i < this.project.tags.length; ++i) {
                    if(this.project.tags[i].id === tag.id) {
                        found = true;
                    }
                }

                if(found === false) {
                    this.project.tags.push(tag);
                }
            },
            removeTag(index) {
                this.project.tags.splice(index, 1);
            },
            setStartsAt(val) {
                this.project.starts_at = val;
            },
            setEndsAt(val) {
                this.project.ends_at = val;
            },
            uploadAttachment(attachment, event, index) {
                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('attachment', file);
                this.uploading = true;

                this.$http.post('/api/documents', data).then(response => {
                    this.project.attachments[index].id = response.data.id;
                }, response => {
                    alert(response.body.attachment.join());
                    event.target.value = '';
                }).finally(() => {
                    this.uploading = false;
                })
            }
        }
    }
</script>