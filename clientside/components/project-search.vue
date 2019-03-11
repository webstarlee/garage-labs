<template>
    <div class="row">
        <div class="col-md-4">
            <!-- Start project filter -->
            <div v-show="selectedItem === 'build'">
                <project-filter v-show="!isService" v-bind:projectFilters="projectFilters"></project-filter>
                <service-filter v-show="isService" v-bind:serviceFilters="serviceFilters"></service-filter>
            </div>
             <!-- End Project search -->

             <!-- Start startup/cofounder filter -->
            <div v-show="selectedItem === 'start'">
                <startup-filter v-show="!isCoFounder" v-bind:startupFilters="startupFilters"></startup-filter>
                <cofounder-filter v-show="isCoFounder" v-bind:cofounderFilters="cofounderFilters"></cofounder-filter>
            </div>
             <!-- End startup/cofounder filter -->
        </div>
       
        <div class="col-md-8">
            <div v-if="selectedItem === 'build'">
                <project-li  v-show="!isService" v-bind:data="project" v-for="project in projects" v-bind:key="project.id"></project-li>
                <service-li  v-show="isService" v-bind:services="projects" ></service-li>
            </div>
            <div v-if="selectedItem === 'start'">
                <startup-li  v-show="!isCoFounder" v-bind:data="project" v-for="project in projects" v-bind:key="project.id"></startup-li>
                <cofounder-li v-show="isCoFounder"  v-bind:data="project" v-for="project in projects" v-bind:key="project.id"></cofounder-li>
            </div>

            <div v-show="loading" class="text-center" style="padding: 25px 0 0;">
                <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
            </div>

            <div v-show="! loading && projects.length === 0">
                <h4 class="text-grey">No projects currently matching the criteria.</h4>
            </div>

            <div v-show="! loading && next_page_url && next_page_url.length" class="btn-group paginator-style">
                <div class="btn-group paginator-style">
                    <ul class="pager">
                        <li><a href="javascript:void(0)" v-on:click="fetch()" rel="next"><i class="glyphicon glyphicon-chevron-down"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import projectLi from '../components/project/li.vue';
    import startupLi from '../components/startup/li.vue';
    import cofounderLi from '../components/co-founder/li.vue';
    import serviceLi from '../components/service/li.vue';
    import startupFilter from '../components/startup/search.vue';
    import cofounderFilter from '../components/co-founder/search.vue';
    import projectFilter from '../components/project/search.vue';
    import serviceFilter from '../components/service/search.vue';

    export default {
        data() {
            return {
                loading: false,
                default_url: '/api/startups',
                next_page_url: '/api/startups',
                projects: [],
                type: [],
                filters: {
                    type: ['project', 'mission', 'startups', 'service'],
                    tag: ''
                },
                selectedItem: 'start',
                isCoFounder: false,
                startupFilters: {
                    project_status: [],
                    skills: []
                },
                cofounderFilters: {
                    i_am: [],
                    skills: []
                },
                projectFilters: {
                    type: [],
                    keyword: '',
                    tag: ''
                },
                serviceFilters: {
                    // categories: [],
                    other: '',
                    category_id: null,
                    subcategory_id: null
                },
                isService: this.$route.query.type === 'service',
                ratting: {}
            }
        },
        created() {
            if(Object.keys(this.$route.query).length !== 0 || this.$route.query.constructor !== Object) {
                this.handleGetParams();
            }

            this.$events.on('searchMissionsFired', this.searchMissions);
            this.$events.on('searchProjectsFired', this.searchProjects);
            this.$events.on('searchServicesFired', this.searchServices);
            this.$events.on('searchStartUpsFired', this.searchStartUps);
            this.$events.on('searchCoFoundersFired', this.searchCoFounders);
            this.$events.on('searchByKeywordFired', this.searchByKeyword);
            this.$events.on('searchAllFired', this.searchAll);
            this.$events.on('searchStartUpsForInvestorFired', this.searchStartUpsForInvestor);
            this.$events.on('startUpFilters', this.doStartUpFilters);
            this.$events.on('cofounderFilters', this.doCofounderFilters);
            this.$events.on('projectFilters', this.doProjectFilters);
            this.$events.on('serviceFilters', this.doServiceFilters);

            this.default_url = this.getApiUrl();
            this.next_page_url = this.default_url;
            this.fetch();
        },
        components: {
            'project-li': projectLi,
            'startup-li': startupLi,
            'cofounder-li': cofounderLi,
            'service-li': serviceLi,
            'startup-filter': startupFilter,
            'cofounder-filter': cofounderFilter,
            'project-filter': projectFilter,
            'service-filter': serviceFilter,
        },
        methods: {
            handleGetParams() {
                let params = this.$route.query;

                if(params.type === 'project') {
                    this.filters.type = ['project'];
                    this.selectedItem = 'build';
                }

                if(params.type === 'service') {
                    this.filters.type = ['service'];
                    this.selectedItem = 'build';
                }

                if(!params.type || params.type === 'startups') {
                    this.filters.type = ['startups'];
                    this.selectedItem = 'start';
                }

                if(params.keyword !== undefined) {
                    this.filters.keyword = params.keyword;
                }

                if(params.tag !== undefined) {
                    this.filters.tag = params.tag;
                }
            },
            getApiUrl() {
                let params = this.$route.query;

                if(params.type === 'project') {
                    this.isCoFounder = false;
                    return '/api/projects';
                }

                if(params.type === 'service') {
                    this.isCoFounder = false;
                    return '/api/services';
                }

                if(params.type === 'grow') {
                    this.isCoFounder = false;
                    return '/api/startups/investor';
                }

                if(params.type === 'cofounders') {
                    this.isCoFounder = true;
                    return '/api/cofounders';
                }

                return '/api/startups';
            },
            searchAll() {
                this.filters = {
                    type: ['project', 'mission'],
                    tag: ''
                };
                this.fetchNew();
            },
            searchByKeyword(keyword) {
                this.default_url = '/api/projects';
                this.filters.keyword = keyword;
                this.fetchNew();
            },
            searchProjects() {
                this.default_url = '/api/projects';
                this.filters.type = ['project'];
                this.selectedItem = 'build';
                this.isService = false;
                this.fetchNew();
            },
             searchServices() {
                this.default_url = '/api/services';
                this.filters.type = ['service'];
                this.selectedItem = 'build';
                this.isService = true;
                this.fetchNew();
            },
            searchMissions() {
                this.default_url = '/api/projects';
                this.filters.type = ['mission'];
                this.isService = false;
                this.fetchNew();
            },
            searchStartUps() {
                this.default_url = '/api/startups';
                this.filters.type = ['startups'];
                this.selectedItem = 'start';
                this.isCoFounder = false;
                this.isService = false;
                this.fetchNew();
            },
            searchStartUpsForInvestor() {
                this.default_url = '/api/startups/investor';
                this.filters.type = ['startups'];
                this.selectedItem = 'start';
                this.isCoFounder = false;
                this.isService = false;
                this.fetchNew();
            },
            searchCoFounders() {
                this.default_url = '/api/cofounders';
                this.filters.type = [];
                this.isCoFounder = true;
                this.isService = false;
                this.fetchNew();
            },
            doStartUpFilters() {
                this.filters = this.startupFilters;
                this.selectedItem = 'start';
                this.isCoFounder = false;
                this.default_url = '/api/startups';
                this.fetchNew();
            },
            doCofounderFilters() {
                this.filters = this.cofounderFilters;
                this.selectedItem = 'start';
                this.isCoFounder = true;
                this.default_url = '/api/cofounders';
                this.fetchNew();
            },
            doProjectFilters() {
                this.filters = this.projectFilters;
                this.selectedItem = 'build';
                this.isService = false;
                this.default_url = '/api/projects';
                this.fetchNew();
            },
            doServiceFilters() {
                this.filters = this.serviceFilters;
                this.selectedItem = 'build';
                this.isService = true;
                this.default_url = '/api/services';
                this.fetchNew();
            },
            fetchNew() {
                this.projects = [];
                this.next_page_url = this.default_url;
                this.fetch();
            },
            fetch() {
                this.loading = true;

                setTimeout(() => {
                    this.$http.get(this.next_page_url, { params: this.filters }).then(response => {
                        this.projects = this.projects.concat(response.data.data);
                        this.next_page_url = response.data.next_page_url;
                    }).then(() => {
                        this.loading = false;
                    });
                }, 0);
            }
        }
    }
</script>