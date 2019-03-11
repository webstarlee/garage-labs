<template>
<div class="col-thumb cofounders-item-container">
    
        <div class="panel">
            <div class="panel-header"  style="display:flex;">
                <div class="cofounder-image">
                     <div class="avartar-wrapper">
                        <a href="/users/45">
                            <img v-if="!data.avatar_path" alt="Image" src="/vendor/avatar/default.jpg" width="50" height="50" class="border-image-profile">
                            <img v-if="data.avatar_path" alt="Image" v-bind:src="data.avatar_path" width="50" height="50" class="border-image-profile">
                        </a>
                    </div>
                </div>
                <div class="cofounder-name">
                     <h1 class="title-shots">
                        <router-link title="Sachin" class="item-link" v-bind:to="`/users/${ data.id }`">{{ data.title }}</router-link>
                    </h1>
                    <p class="cofounder-joined">
                        <template v-if="data.country_name && data.city_name">
                            <i class="glyphicon glyphicon-map-marker"></i> {{ data.city_name ? data.city_name : '' }}, {{ data.country_name ? data.country_name : '' }}<br>
                        </template>
                    </p>
                    
                </div>
            </div>
            <div class="panel-body">
                <div class="user-overview">
                    {{data.presentation}}
                </div>
                <div class="user-type">
                   
                    <div class="project-status-option">
                        <span class="ns-icon ns-icon-16">
                            <img v-if="data.i_am.indexOf('2') !== -1" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            Inverstor
                        </span>
                    </div>
                    <div class="project-status-option">
                        <span class="ns-icon ns-icon-16">
                            <img v-if="data.i_am.indexOf('1') !== -1" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            Entrepreneur
                        </span>
                    </div>
                    <div class="project-status-option">
                        <span class="ns-icon ns-icon-16">
                            <img v-if="data.i_am.indexOf('0') !== -1" src="/vendor/img/custom-icon/ic-check-y.png"/>
                             <img v-else src="/vendor/img/custom-icon/ic-check-n.png"/>
                        </span>
                        <span style="display:inline-block;">
                            Provider
                        </span>
                    </div>
                </div>
                   <!--  <div class="skill-wrapper">
                        <button style="margin-right: 5px;" v-for="skill in data.skills" v-bind:key="skill.id" class="btn btn-tag btn-xs">{{ skill.name }}</button>
                    </div> -->
            </div>
      
        </div>
</div>
</template>

<script>
    export default {
        props: ['data']
    }
</script>