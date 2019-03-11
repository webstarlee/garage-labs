<template>
    <div class="col-thumb startup-item-container">
        <div class="panel container">

            <div class="col-sm-12 no-padding">
                <div class="col-sm-1 no-padding">
                   <div class="panel-startup-logo" style="margin-right:15px;" v-bind:style="{'background-image': data.logo ? getBackgroundImage(data.logo_url) : ''}">
                        <img v-if="!data.logo" src="/vendor/img/startup-logo.jpg" alt="">
                    </div>
                </div>
                <div class="col-sm-11 panel-header">
                    <h2 class="panel-name">
                        <router-link class="item-link" v-bind:to="`/startups/${ data.slug }`">{{ data.title }}</router-link>
                    </h2>
                    <div class="startup-tags">
                    <span class="ns-icon ns-icon-16">
                        <img src="/vendor/img/custom-icon/ic-tag-16.png" alt="">
                    </span>
                         <button style="margin-right: 5px;" v-for="category in data.categories" v-bind:key="category.id" class="btn btn-tag btn-xs">{{ category.name }}</button>
                    </div>
                    <div class="startup-stats">
                        <ul class="list-inline">
                            <li>
                                <span class="ns-icon ns-icon-16">
                                    <img src="/vendor/img/custom-icon/ic-clock-16.png" alt="">
                                </span>
                                <font color="green">Open</font>
                                {{ data.created_at | moment("from") }}
                            </li>
                            <li>
                                <span class="ns-icon ns-icon-16">
                                    <img src="/vendor/img/custom-icon/ic-eye-16.png" alt="">
                                </span>
                                {{ data.views }} <span v-if="data.views > 1"> vues</span><span v-else> vue</span>
                            </li>
                         </ul>
                    </div>
                    <div class="startup-fonds">
                        <span class="ns-icon ns-icon-16">
                                    <img src="/vendor/img/custom-icon/ic-fonds.png" alt="">
                        </span>
                        <span v-if="data.fonds_type">{{ data.fonds_type.name }}</span>
                    </div>
                </div>
            </div>

            <div class="col-sm-12 panel-body">

                <div class="col-sm-offset-1 startup-desc">
                    <p>
                        {{data.concept}}
                    </p>
                </div>
                <div class="col-sm-offset-1 startup-feaut">
                 <div class="project-status project-status-wrapper">


                    <div class="project-status-option">

                        <span class="ns-icon ns-icon-16">
                            <img v-if="data.project_status.indexOf('0') !== -1" src="/vendor/img/custom-icon/ic-check-y.png"/>
                        </span>
                        <span style="display:inline-block;">
                            Idea
                        </span>
                    </div>
                    <div class="project-status-option">
                       <span class="ns-icon ns-icon-16">
                            <img v-if="data.project_status.indexOf('1') !== -1" src="/vendor/img/custom-icon/ic-check-y.png"/>
                            <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            Business plan/model
                        </span>
                    </div>
                    <div class="project-status-option">
                       <span class="ns-icon ns-icon-16">
                            <img v-if="data.project_status.indexOf('2') !== -1" src="/vendor/img/custom-icon/ic-check-y.png"/>
                            <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            MVP
                        </span>
                    </div>
                    <div class="project-status-option">
                             <img v-if="data.project_status.indexOf('3') !== -1" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            1st customers
                        </span>
                    </div>
                    <div class="project-status-option">
                             <img v-if="data.project_status.indexOf('4') !== -1" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            Funded
                        </span>
                    </div>

                </div> 
                </div>

            </div>

            <!-- <div class="caption" style="margin-left:4px">
                <h1 class="title-shots">
                    <router-link class="item-link" v-bind:to="`/startups/${ data.slug }`">{{ data.title }}</router-link>
                </h1>
            </div> -->



            <!-- <div class="bottom-row-wrapper">
                <div class="category-wrapper">
                    <button style="margin-right: 5px;" v-for="category in data.categories" v-bind:key="category.id" class="btn btn-tag btn-xs">{{ category.name }}</button>
                </div>
               
                <div class="caption">
                    <p class="actions">
                        <span class="pull-right">
                        <i class=""></i> <span class="like_count myicon-right strongSpan">
                            <font color="green">Open</font>
                            {{ data.created_at | moment("from") }}
                        </span>
                        <i class="fa fa-eye myicon-right"></i> <span class="myicon-right strongSpan">{{ data.views }} views</span>
                        </span>
                    </p>
                </div>
            </div> -->
        </div>
    </div>
</template>

<script>
    export default {
        props: ['data'],
         methods: {
            getBackgroundImage(path) {
                return `url(${path})`;
            }
         }
    }
</script>

<style>
    .startup-fonds {
            font-size: 12px;
    color: #737976;
    }

    .panel-startup-logo {
        width: 58px;
        height: 59px;
        background-size: cover;
        background-position: center;
    }
</style>