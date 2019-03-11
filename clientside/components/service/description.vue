<template>
    <div>
        <div class="service-detail-container">
            <div class="header row">
                <div class="title col-md-8">{{data.title}}</div>
                <div class="author-wrapper col-md-4">
                    <div class="author">
                        <div class="left-col">
                            <router-link v-bind:to="`/users/${ data.author_id }`" class="btn-block photo-card-live myprofile">
                                <img class="border-image-profile img-circle photo-card"
                                    alt="Image"
                                    v-bind:src="data.author.avatar_path">
                            </router-link>
                        </div>
                        <div class="right-col">
                            <div class="name">
                                <router-link v-bind:to="`/users/${ data.author.id }`">{{data.author.first_name + ' ' + data.author.last_name}}</router-link>
                            </div>
                            <div class="rating">
                                <div class="stars">
                                    <star-rating v-bind:star-size="12" v-bind:show-rating="false" v-model="data.author.avg_stars" v-bind:read-only="true"></star-rating>
                                    <span><span class="avg-review">({{numberReviewers + (numberReviewers > 1 ? ' reviews' : ' review')}})</span></span>
                                </div>
                                <div class="reviews"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="description-wrapper">
                <div class="image-wrapper row" v-if="data.galleries && data.galleries.length > 0">
                    <div class="main title col-md-7">
                        <img v-if="data.galleries[currentIndex].type==='image'" v-bind:src="data.galleries[currentIndex].url" width="100%" />
                        <iframe v-if="data.galleries[currentIndex].type==='video'" v-bind:src="data.galleries[currentIndex].embed_url" width="100%" height="400px" frameborder="0" allowfullscreen></iframe>
                    </div>
                    <div class="slide col-md-5 hidden-sm hidden-xs">
                        <div class="row">
                            <div class="col-md-6 side-image" v-for="(gallery,index) in data.galleries" >
                                <a href="javascript:void(0)" v-on:click="changeMainImage(index)">
                                    <div class="image-thumbnail" v-if="gallery.type==='image'" v-bind:style="{'background-image': getBackgroundImage(gallery.url)}">
                                    </div>
                                    <div class="video-thumbnail" v-bind:style="{'background-image': getBackgroundImage(gallery.video_thumbnail)}" v-if="gallery.type==='video'">
                                        <img src="/vendor/img/play.png" alt="" width="64px" height="64px">
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="description">
                    <div>Description</div>
                    <div>{{data.description}}</div>
                </div>
            </div>
        </div>  
    </div>
</template>

<script>
    import starRating from 'vue-star-rating';
    export default {
        props: ['data', 'numberReviewers'],
        data() {
            return {
                currentIndex: 0
            }
        },
        created() {
        },
        methods: {
            changeMainImage(index) {
                if (this.currentIndex === index) {
                    return;
                }

                this.currentIndex = index;
            },
            getBackgroundImage(path) {
                return `url(${path})`;
            }
        },
         components: {
             'star-rating': starRating
         }
        }
</script>
<style>
.service-detail-container .title {
    font-weight: bold;
    font-size: 18px;
    text-align: left;
}

.service-detail-container .header {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    align-items: center;
}

.service-detail-container .header .author-wrapper {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: column nowrap;
    flex-flow: column nowrap;
    align-items: flex-end;
    font-size: 14px;
    text-align: left;
}

.service-detail-container .author {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    margin: 10px 0;
}
.service-detail-container .author .left-col {
    width: 30px;
}

.service-detail-container .author .left-col img {
    display: inline-block;
    border-radius: 50%;
    height: 30px;
    width: 30px;
}

.service-detail-container .author .right-col {
    margin-left: 5px;
    line-height: 14px;
    display: flex;
    flex-flow: column nowrap;
    -webkit-flex-flow: column nowrap;
    justify-content: center;
}

.service-detail-container .author .right-col .name {
}

.service-detail-container .stars {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
}

.service-detail-container .description-wrapper .description {
    margin-top: 10px;
    padding-bottom: 10px;
    border-bottom: 0.5px solid #b3b3b3;
}

.service-detail-container .side-image {
    height: 200px;
}

.service-detail-container .video-thumbnail {
    height: 200px;
    background-size: cover;
    background-position: center;
    display: flex;
    justify-content: center;
    align-items: center;
}

.service-detail-container .image-thumbnail {
    height: 200px;
    background-size: cover;
    background-position: center;
}
</style>