<template>
    <div>
        <div class="jumbotron static-header">
            <div class="container wrap-jumbotron">
                <h1 class="title-item none-overflow">
                     
                    
                    <router-link to="/projects/create" class="ns-btn btn-sm ns-btn-ghost-yel" style="max-width:300px">
                        Déposer un projet ou une mission similaire
                    </router-link>
                </h1>
            </div>
        </div>
        <div class="container wrap-ui">
            <div class="row">
                <div class="col-md-8">
                    <project-description v-bind:data="project" v-bind:loading="loading"></project-description>
                    <proposals-list v-if="! loading && project" v-bind:project="project" v-bind:contact="author.contact_link"></proposals-list>
                </div>
                <div class="col-md-4">
                    <div class="responsive-side collapse">
                        <project-author v-bind:data="author" v-bind:loading="loading"></project-author>
                        <project-details v-bind:data="project" v-bind:loading="loading"></project-details>
                        <ad></ad>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import projectDescription from '../components/project/description.vue';
    import sendProposal from '../components/project/send-proposal.vue';
    import proposalsList from '../components/project/proposals-list.vue';
    import projectAuthor from '../components/project/author.vue';
    import projectDetails from '../components/project/details.vue';
    import ad from '../components/ad.vue';

    export default {
        data() {
            return {
                loading: true,
                project: null
            }
        },
        created() {
            setTimeout(() => {
                this.load();
            }, 0);
        },
        computed: {
            author() {
                if(this.project) {
                    return this.project.author;
                } else {
                    return null;
                }
            }
        },
        methods: {
            load() {
                this.loading = true;

                this.$http.get(`/api/projects/${ this.$route.params.slug }`).then(response => {
                    this.project = response.data;
                }, response => {
                    //
                }).then(() => {
                    this.loading = false;
                });
            }
        },
        components: {
            'project-description': projectDescription,
            'send-proposal': sendProposal,
            'proposals-list': proposalsList,
            'project-author': projectAuthor,
            'project-details': projectDetails,
            'ad': ad
        }
    }
</script>