<template>
    <div>
        <div class="feedback-container">
            <div class="feedback-detail">
                <div class="author-wrapper">
                        <div class="author" v-for="feedback in feedbacks">
                            <div class="left-col">
                                <router-link v-bind:to="`/users/${ feedback.buyer_id ? feedback.buyer_id : feedback.author_id }`" class="btn-block photo-card-live myprofile">
                                    <img class="border-image-profile img-circle photo-card"
                                        alt="Image"
                                        v-bind:src="feedback.author.avatar_path">
                                </router-link>
                            </div>
                            <div class="right-col">
                                <div class="rating">
                                    <div class="stars">
                                        <star-rating v-bind:star-size="12" v-bind:show-rating="false" v-model="feedback.rating" v-bind:read-only="true"></star-rating>
                                        <span>({{feedback.rating}}/5)</span>
                                    </div>
                                    <div class="reviews">{{feedback.message}}</div>
                                    <div class="reviewer-title">
                                        <span class="review-date">{{feedback.created_at | moment("DD MMM YYYY")}}</span>
                                        <span class="fa fa-align-left"></span>
                                        <span>
                                            <router-link v-if="feedback.project" v-bind:to="`/projects/${feedback.project.slug}`">
                                            {{feedback.project.title}}
                                            </router-link>
                                            <router-link v-if="feedback.package" v-bind:to="`/service/detail/${feedback.package.service.id}`">
                                            {{feedback.package.service.title}}
                                            </router-link>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
        </div>  
    </div>
</template>

<script>
    import starRating from 'vue-star-rating';
    export default {
        props: ['feedbacks'],
        data() {
            return {
            }
        },
        methods: {
        },
         components: {
            'star-rating': starRating
         }
        }
</script>
<style>
.border-bottom {
    border-bottom: 2px solid #b3b3b3;
}

.feedback-container .author-wrapper {
    padding: 10px 0;
}

.feedback-container .author {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    margin: 10px 0;
}
.feedback-container .author .left-col {
    width: 30px;
}

.feedback-container .author .left-col img {
    display: inline-block;
    border-radius: 50%;
    height: 30px;
    width: 30px;
}

.feedback-container .author .right-col {
    margin-left: 5px;
    line-height: 16px;
}

.feedback-container .stars {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
}

.feedback-container .avg-review {
    margin-left: 10px;
    font-weight: bold;
}

.feedback-container .reviews {
    font-weight: bold;
}

.feedback-container .reviewer-title {
   
    font-style: italic;
    font-size: 11px;
}

.feedback-container .review-date {
    margin-right: 10px;
}
</style>