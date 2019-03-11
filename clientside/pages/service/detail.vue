<template>
    <div class="row content-wrapper">
        <div class="col-md-10 col-md-offset-1">
            <div class="panel panel-default detail-container">
                <div>
                    <service-description v-bind:data="service" v-bind:numberReviewers="packageFeedbacks.length + projectFeedbacks.length"></service-description>
                </div>
                <div class="row orders">
                    <order v-bind:packages="service.packages"></order>
                </div>
                <div class="feedback">
                    <div class="feedback-container">
                        <div class="author-wrapper border-bottom">
                            <div class="author">
                                <div class="left-col">
                                    <img v-bind:src="service.author && service.author.avatar_path" />
                                </div>
                                <div class="right-col">
                                    <div class="name">
                                        <span>{{service.author.first_name + ' ' + service.author.last_name}}</span>
                                        <span class="avg-review">({{packageFeedbacks.length + projectFeedbacks.length}} reviews)</span>
                                    </div>
                                    <div class="rating">
                                        <div class="stars">
                                            <star-rating v-bind:star-size="12" v-bind:show-rating="false" v-model="service.author.avg_stars" v-bind:read-only="true"></star-rating>
                                        </div>
                                        <div class="reviews"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <feedbacks v-bind:feedbacks="packageFeedbacks"></feedbacks>
                    <feedbacks v-bind:feedbacks="projectFeedbacks"></feedbacks>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import serviceDescription from '../../components/service/description.vue';
    import order from '../../components/service/order.vue';
    // import feedback from '../../components/service/feedback.vue';
    import feedbacks from '../../components/common/feedbacks.vue';
    import starRating from 'vue-star-rating';

    export default {
        data() {
            return {
                service: {
                    images: [],
                    packages: [],
                    videos: [],
                    galleries: []
                },
                loading: false,
                projectFeedbacks: [],
                packageFeedbacks: []
            }
        },
        created() {
            this.getServiceById(this.$route.params.id);
        },
        components: {
            'service-description': serviceDescription,
            'order': order,
            // 'feedback': feedback,
            'feedbacks': feedbacks,
            'star-rating': starRating
        },
        methods: {
            getServiceById(id) {
                this.loading = true;
                this.$http.get(`/api/services/by-id/${id}`).then(response => {
                    response.data.images = [];
                    response.data.videos = [];
                    this.service = response.data;
                    this.fetchUserFeedbacks();
                }).finally(() => {
                    this.loading = false;
                });
            },
			fetchUserFeedbacks() {
				this.loading = true;
                this.$http.get(`/api/users/user-feedbacks/${this.service.author_id}`).then(response => {
                    this.projectFeedbacks = response.data.projectFeedbacks;
					this.packageFeedbacks = response.data.packageFeedbacks;
                }).finally(() => {
                    this.loading = false;
                });
			}
        }
    }
</script>
<style>
.detail-container {
    margin: 10px;
}
</style>