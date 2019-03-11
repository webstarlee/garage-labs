<template>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <div v-if="! loading" class="col-md-8">
                <h1 class="title-item none-overflow">
                    Projets
                    <template v-if="! loading && projects.length > 0">
                        <small>({{ projects.length }})</small>
                    </template>
                </h1>
                <hr>
                <div v-for="project in projects" class="media media-designer">
                    <span class="pull-left">
                        <router-link class="image-thumb"
                                     v-bind:to="`/users/${ project.author_id }`"
                        >
                            <img width="80"
                                 height="80"
                                 class="media-object img-circle"
                                 v-bind:src="project.author.avatar_path"
                            />
                        </router-link>
                    </span>
                    <div class="media-body media-jobs">
                        <div class="pull-left">
                            <h4 class="media-heading">
                                <router-link class="link-user-profile"
                                             v-bind:to="`/projects/${ project.id }`"
                                >{{ project.title }}</router-link>
                                <template v-if="project.status === 'opened'">
                                    <span class="text-success"><strong>{{ project.status | capitalize }}</strong></span>
                                </template>
                                <template v-else>
                                    <span class="text-danger"><strong>{{ project.status | capitalize }}</strong></span>
                                </template>
                            </h4>
                            <ul class="list-group list-designer">
                                <li>
                                    <router-link v-bind:to="`/projects/${ project.id }`" class="links-ds">
                                        {{ project.proposals_count }} propositions
                                    </router-link>
                                </li>
                                <li>
                                    {{ project.created_at | moment('MMMM Do YYYY') }}
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div v-if="! loading && projects.length === 0">
                    Aucun projet actuellement.
                </div>
            </div>
            <div v-else class="col-md-8 text-center" style="padding: 80px 0;">
                <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
            </div>
            <div class="col-md-4">
                <ad></ad>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import ad from '../../components/ad.vue';

    export default {
        data() {
            return {
                loading: true,
                projects: []
            }
        },
        created() {
            setTimeout(() => {
                this.fetch();
            }, 0);
        },
        components: {
            ad
        },
        methods: {
            fetch() {
                this.loading = true;

                this.$http.get(`/api/users/${ this.$route.params.id }/projects`).then(response => {
                    this.projects = response.data;
                }, response => {

                }).finally(() => {
                    this.loading = false;
                })
            }
        }
    }
</script>