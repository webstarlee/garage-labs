<template>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <div v-if="! loading" class="col-md-8">
                <h1 class="title-item none-overflow">
                    Evaluations
                    <template v-if="feedbacks.length > 0">
                        <small>(note {{ meta.average_rating }}% - {{ meta.count }})</small>
                    </template>
                </h1>
                <hr>
                <div v-if="feedbacks.length === 0">
                    Aucune évaluation
                </div>
                <div v-for="feedback in feedbacks" class="media media-designer">
                    <span class="pull-left">
                        <router-link class="image-thumb" v-bind:to="`/users/${ feedback.author_id }`">
                            <img width="80"
                                 height="80"
                                 class="media-object img-circle"
                                 v-bind:src="feedback.author.avatar_path"
                            >
                        </router-link>
                    </span>
                    <div class="media-body media-jobs">
                        <div class="pull-left">
                            <h4 class="media-heading">
                                <router-link class="link-user-profile"
                                             v-bind:to="`/users/${ feedback.author_id }`"
                                >{{ feedback.author.username }}</router-link>
                            </h4>
                            <ul class="list-group list-designer">
                                <li>
                                    <router-link v-bind:to="`/projects/${ feedback.project.slug }`" class="links-ds">
                                        <strong>{{ feedback.project.title }}</strong>
                                    </router-link> ({{ feedback.rating }}/5)
                                    <p style="margin-bottom: 0;">
                                        {{ feedback.message }}
                                    </p>
                                    <small>{{ feedback.created_at | moment('MMMM Do YYYY') }}</small>
                                </li>
                            </ul>
                        </div>
                    </div>
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
                feedbacks: [],
                meta: {},
                loading: true
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

                this.$http.get(`/api/users/${ this.$route.params.id }/feedbacks`).then(response => {
                    this.feedbacks = response.data.feedbacks;
                    this.meta = response.data.meta;
                }, response => {
                    console.log(response);
                }).finally(() => {
                    this.loading = false;
                });
            }
        }
    }
</script>