<template>
    <div class="content-wrapper">
        <div class="jumbotron static-header">
            <div class="container wrap-jumbotron">
                <h1 class="title-item none-overflow">
                    <router-link to="/" class="link-home">
                        <i class="glyphicon glyphicon-home myicon-right"></i> <i class="fa fa-angle-right"></i>
                    </router-link> {{createProjectConfig.title}}
                </h1>
            </div>
        </div>
        <div class="container wrap-ui">
            <div class="row">
                <div class="col-md-offset-2 col-md-8">
                    <div class="panel panel-default project text-center">
                        <div class="panel-heading grid-panel-title">
                            <div class="btn-block">
                                <span v-bind:class="{ active: stage === 1 }" class="nav-span"><span class="badge">1</span> {{createProjectConfig.step1}}</span>
                                <i class="fa fa-angle-right" style="margin: 0px 15px 0px 15px;"></i>
                                <span v-bind:class="{ active: stage === 2 }" class="nav-span"><span class="badge">2</span> {{createProjectConfig.step2}}</span>
                            </div>
                        </div>
                        <div v-show="stage === 1" class="panel-body">
                            <form v-on:submit.prevent="moveForward()" class="form-horizontal form-account" role="form">
                                <fieldset v-bind:disabled="loading">
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.title !== undefined && errors.title.length }">
                                        <label class="col-sm-2 control-label input-sm">{{createProjectConfig.form_title}}
                                        </label>
                                        <div class="col-sm-10">
                                            <input v-model="project.title" type="text" name="job_title" class="form-control input-sm" placeholder="Title">
                                            <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                        </div>
                                    </div>
                                    <!-- **** form-group **** -->
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.categories !== undefined && errors.categories.length }">
                                        <label class="col-sm-2 control-label input-sm">{{createProjectConfig.form_category}}</label>
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
                                            + <a href="javascript:void(0)" @click="addCategory()"><u>{{createProjectConfig.form_add_more_categories}}</u></a>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.description !== undefined && errors.description.length }">
                                        <label class="col-sm-2 control-label input-sm">{{createProjectConfig.form_description}}</label>
                                        <div class="col-sm-10">
                                            <textarea v-model="project.description"
                                                      class="form-control input-sm"
                                                      style="height: 100px"
                                            ></textarea>
                                            <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.tags !== undefined && errors.tags.length }">
                                        <label class="col-sm-2 control-label input-sm">{{createProjectConfig.form_skill}}/<br/>{{createProjectConfig.form_technology}}</label>
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
                                        <label class="col-sm-2 control-label input-sm">{{createProjectConfig.form_budget}} (€) *</label>
                                        <div class="col-sm-10">
                                            <input v-model="project.budget" type="text" class="form-control input-sm">
                                            <p v-if="errors.budget !== undefined" class="help-block">{{ errors.budget.join() }}</p>
                                        </div>
                                    </div>
                                    <div class="form-group" v-bind:class="{ 'has-error': errors.starts_at !== undefined && errors.starts_at.length }">
                                        <label for="starts-at" class="col-sm-2 control-label input-sm">{{createProjectConfig.form_start_date}} *</label>
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
                                        <label for="ends_at" class="col-sm-2 control-label input-sm">{{createProjectConfig.form_end_date}}</label>
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
                                    <div class="form-group mb-0">
                                        <label class="col-sm-2 control-label input-sm">{{createProjectConfig.form_attachment}}</label>
                                        <div class="col-sm-10">
                                            + <a href="javascript:void(0)" @click="project.attachments.push({})"><u>{{createProjectConfig.form_add_a_document}} (jpeg, png, doc(x), ppt(x), pdf, xls, csv, txt)</u></a>
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
                                </fieldset>
                            </form>
                        </div>
                        <div v-show="stage === 2" class="panel-body" style="text-align: left;">
                            <div class="form-horizontal">
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_type}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">{{ project.type }}</div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_title}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">{{ project.title }}</div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_category}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">
                                        <ul>
                                            <li v-for="category in project.categories">{{ getCategoryName(category.id) }}</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_description}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">
                                        <p>{{ project.description }}</p>
                                    </div>
                                </div>
                                <div v-if="project.tags !== undefined && project.tags.length" class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_skill}}/{{createProjectConfig.form_technology}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">
                                        <ul>
                                            <li v-for="tag in project.tags">{{ tag.name }}</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_start_date}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">{{ project.starts_at | moment('MMMM Do YYYY') }}</div>
                                </div>
                                <div v-if="project.ends_at" class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_end_date}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">{{ project.ends_at | moment('MMMM Do YYYY') }}</div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_contact_phone}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">{{ project.contact_phone }}</div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_show_phone_no}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">{{ project.show_phone ? 'Yes' : 'No' }}</div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_contact_email}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">{{ project.contact_email }}</div>
                                </div>
                                <div class="form-group mb-0">
                                    <label class="col-sm-3 control-label input-sm">{{createProjectConfig.form_show_email}}</label>
                                    <div class="col-sm-8 col-sm-offset-1">{{ project.show_email ? 'Yes' : 'No' }}</div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group panel-body mb-0">
                            <div class="col-sm-offset-2 col-sm-10 pl-0">
                                <button @click="moveForward()" class="ns-btn ns-btn-yel" style="width:150px; margin-right:10px;">
                                    <template v-if="stage < 2">
                                        {{createProjectConfig.form_next_button}}
                                    </template>
                                    <template v-else>
                                        {{createProjectConfig.form_submit_button}}
                                    </template>
                                </button>
                                <a href="javascript:void(0)" @click="moveBack()" class="ns-btn btn-inverse" style="width:150px;">
                                   {{createProjectConfig.form_cancel_button}}
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
                categories: [],
                tag: '',
                loading: true,
                project: {
                    type: 'project',
                    contact_phone: this.$store.getters.user.company_phone || this.$store.getters.user.phone,
                    contact_email: this.$store.getters.user.email,
                    starts_at: '',
                    ends_at: '',
                    categories: [],
                    attachments: [{}],
                    tags: []
                },
                errors: [],
                createProjectConfig: {}
            }
        },
        created() {
            this.fetchCategories();
            this.addCategory();
            this.fetchContentEn();
        },
        methods: {
            fetchCategories() {
                this.$http.get('/api/categories').then(response => {
                    this.categories = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            checkProjectFirstRequest() {
                this.errors = {};
                this.loading = true;

                return this.$http.post('/api/projects/check-1', this.project);
            },
            checkProjectSecondRequest() {
                this.errors = {};
                this.loading = true;

                return this.$http.post('/api/projects/check-2', this.project);
            },
            addCategory() {
                this.project.categories.push({});
            },
            moveForward() {
                if(this.stage === 1) {
                    this.checkProjectFirstRequest().then(response => {
                        this.stage += 1;
                    }, response => {
                        this.errors = response.data;
                    }).finally(() => {
                        this.loading = false;
                    });
                }

                if(this.stage === 2) {
                    this.$http.post('/api/projects/create', this.project).then(response => {
                        this.$router.push(`/projects/${ response.data.slug }`);
                    });
                }
            },
            moveBack() {
                this.stage -= 1;
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
                this.loading = true;

                this.$http.post('/api/documents', data).then(response => {
                    this.project.attachments[index].id = response.data.id;
                }, response => {
                    alert(response.body.attachment.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
                })
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
            getCategoryName(id) {
                var category = this.categories.find(function(cat) {
                    return cat.id === id;
                    });
                
                if (!category) {
                    return null;
                }

                return category.name;
            },
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.createProjectConfig = response.body.create_project;
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