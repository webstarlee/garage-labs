<template>
    <div>
        <div class="">
            <div id="videoModal" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" v-on:click="closePlayVideoModal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="panel panel-default">
                                <div class="position-relative">
                                    <div class="btn-block">
                                        <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                                            <iframe  :src="embed_url" width="100%" height="400px" frameborder="0" allowfullscreen></iframe>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="service-container">
                <div class="panel panel-default service-card" v-for="data in services" v-bind:key="data.id">
                <div v-bind:style="{'background-image': getBackgroundImage()}" v-if="data.videos.length === 0 && data.images.length === 0" class="default-background">
                    <div class="image-wrapper">
                            <div>
                                <div>
                                {{data.description.substring(0, 100) }}
                                </div>
                            </div>
                        </div>
                        <div class="description">
                            <div class="title"><router-link v-bind:to="`/service/detail/${data.id}`">{{data.title}}</router-link></div>
                            <div class="author">
                                <div class="left-col">
                                    <router-link v-bind:to="`/users/${ data.author.id }`" class="btn-block photo-card-live myprofile">
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
                                            <span>({{data.author.num_reviews + (data.author.num_reviews > 1 ? ' reviews' : ' review')}})</span>
                                        </div>
                                        <div class="reviews"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-else>
                        <div class="image-wrapper">
                                <slick  v-bind:images="combinedImages(data.images, data.videos)" v-on:onPlayVideo="playVideo"></slick>
                                <!--div v-if="data.videos.length > 0" class="video-wrapper">
                                    <iframe v-bind:src="data.videos[0].embed_url" width="100%" height="100%" frameborder="0" allowfullscreen></iframe>
                                </div-->
                                <div v-if="data.videos.length === 0 && data.images.length === 0">
                                    <div>
                                    {{data.description.substring(0, 100) }}
                                    </div>
                                </div>
                            </div>
                            <div class="description">
                                <div class="title"><router-link v-bind:to="`/service/detail/${data.id}`">{{data.title}}</router-link></div>
                                <div class="author">
                                    <div class="left-col">
                                        <router-link v-bind:to="`/users/${ data.author.id }`" class="btn-block photo-card-live myprofile">
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
                                                <span>({{data.author.num_reviews + (data.author.num_reviews > 1 ? ' reviews' : ' review')}})</span>
                                            </div>
                                            <div class="reviews"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="footer">
                        <span class="fa fa-eye myicon-right color-strong"></span>
                        <span>STARTING FROM {{data.packages[0].price}}&euro;</span>
                    </div>
                </div>
            </div>
        </div>    
    </div>
    
</template>

<script>
    import slick from '../common/slick.vue';
    import starRating from 'vue-star-rating';
    export default {
        props: ['services'],
        data() {
            return {
                embed_url: null
            }
        },
        created() {
            this.$events.on('playVideoFired', this.playVideo);
        },
        methods: {
            combinedImages(images, videos) {
                var tempArr = [];
                if (images && images.length > 0) {
                    tempArr = images;
                }

                var len = videos.length;
                if (len > 0) {
                    for (var i = 0; i < len; i++) {
                        tempArr.push({url: videos[i].video_thumbnail, is_video: true, embed_url: videos[i].embed_url});
                    }
                }

                return tempArr;
            },
            playVideo(url) {
               this.embed_url = url;
               $("#videoModal").modal("show");
            },
            closePlayVideoModal() {
                this.embed_url = null;
               $("#videoModal").modal("hide");
            },
            getBackgroundImage() {
                return 'url(vendor/img/service-bg-50.png)';
            }
        },
         components: {
            'slick': slick,
            'star-rating': starRating
         }
        }
</script>
<style>
.service-container {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row wrap;
    flex-flow: row wrap;
    width: 100%;
    font-size: 14px;
    justify-content: center;
}

.service-card {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: column nowrap;
    flex-flow: column nowrap;
    width: 250px;
    min-height: 300px;
    padding: 0;
    margin: 5px;
}

.service-card .description {
    padding-left: 5px;
}

.service-card .image-wrapper {
    height: 180px;
}

.service-container .author {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    margin: 10px 0;
}
.service-container .author .left-col {
    width: 30px;
}

.service-container .author .left-col img {
    display: inline-block;
    border-radius: 50%;
    height: 30px;
    width: 30px;
}

.service-container .author .right-col {
    margin-left: 5px;
    line-height: 14px;
    display: flex;
    flex-flow: column nowrap;
    -webkit-flex-flow: column nowrap;
    justify-content: center;
}

.service-container .author .right-col .name {
    font-size: 11px;
}

.service-container .stars {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    font-size: 11px;
}

.service-container .footer {
    border: 0.5px solid #b3b3b3;
    padding: 5px;
}

.default-background {
    background-position: center;
    background-size: cover;
}

@media (min-width: 576px) {
    .service-container {
        justify-content: flex-start;
    }
}
</style>