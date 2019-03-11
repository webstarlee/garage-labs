<template>
    <div class="slick-container slick-background" v-bind:style="{'background-image': getBackgroundImage(images[currentIndex].url)}">
        <div class="previous navigate-wrapper" v-show="images.length !== 1 && currentIndex !== 0">
            <a v-on:click="previous()" style="color: #fff"><i class="fa fa-chevron-circle-left" aria-hidden="true"></i></a>
        </div>
        <div class="image">
            <a href="javascript:void(0);" v-on:click="playVideo(images[currentIndex].embed_url)" v-if="images[currentIndex].is_video">
                <img src="/vendor/img/play.png" alt="" class="play-button" width="64px" height="64px" >
            </a>
        </div>
        <div class="next navigate-wrapper" v-show="images.length !== 1 && currentIndex !==  images.length - 1">
        <a v-on:click="next()" style="color: #fff"><i class="fa fa-chevron-circle-right" aria-hidden="true"></i></a>
        </div>
    </div>
</template>

<script>
    export default {
        props: ['images'],
        data() {
            return {
                currentIndex: 0
            }
        },
        methods: {
            previous() {
                if (this.currentIndex > 0) {
                    this.currentIndex--;
                }
            },
            next() {
                if (this.currentIndex < this.images.length - 1) {
                    this.currentIndex++;
                }
            },
            getBackgroundImage(path) {
                return `url(${path})`;
            },
            playVideo(url) {
                this.$events.emit('playVideoFired', url);
            }
        }
        }
</script>
<style>
.slick-container {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    width: 100%;
    height: 100%;
}

.slick-container .navigate-wrapper {
    display: flex;
    flex-flow: column nowrap;
    justify-content: center;
}

.slick-container .navigate-wrapper .fa {
    font-size: 2em;
    cursor: pointer;
}

.slick-container .previous {
    margin-right: 10px;
}

.slick-container .next {
    margin-left: 10px;
}


.slick-container .image {
    width: 85%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.slick-background {
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
}


</style>