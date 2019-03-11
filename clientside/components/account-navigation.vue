<template>
    <div class="list-group">
     <!-- **** list-group-item **** -->
        <router-link to="/user/dashboard" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/dashboard' }">
            <i class="icon-bullhorn myicon-right"></i> {{navigationConfig.menus[0]}}
            <span class="pull-right">
                <i class="fa fa-chevron-right "></i>
            </span>
        </router-link> <!-- **** ./ list-group-item **** -->

        <!-- **** list-group-item **** -->
        <router-link to="/user/projects" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/projects' }">
            <i class="icon-bullhorn myicon-right"></i> {{navigationConfig.menus[1]}}
            <span class="pull-right">
                <i class="fa fa-chevron-right "></i>
            </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <!-- **** list-group-item **** -->
        <router-link to="/user/prospected" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/prospected' }">
            <i class="icon-pushpin myicon-right"></i> {{navigationConfig.menus[2]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <!-- **** list-group-item **** -->
        <router-link to="/user/startups" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/startups' }">
            <i class="icon-bullhorn myicon-right"></i> {{navigationConfig.menus[3]}}
            <span class="pull-right">
                <i class="fa fa-chevron-right "></i>
            </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <!-- **** list-group-item **** -->
        <router-link to="/user/startup-prospected" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/startup-prospected' }">
            <i class="icon-pushpin myicon-right"></i> {{navigationConfig.menus[4]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <!-- **** list-group-item **** -->
        <router-link to="/user/messages" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/messages' }">
            <i class="fa fa-envelope myicon-right"></i> {{navigationConfig.menus[5]}}
            <span class="pull-right">
                <i class="fa fa-chevron-right "></i>
            </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <!-- **** list-group-item **** -->
        <router-link to="/user/profile" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/profile' }">
            <i class="glyphicon glyphicon-pencil myicon-right"></i> {{navigationConfig.menus[6]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <!-- **** list-group-item **** -->
        <router-link to="/user/avatar" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/avatar' }">
            <i class="glyphicon glyphicon-camera myicon-right"></i> {{navigationConfig.menus[7]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <!-- **** list-group-item **** -->
        <router-link to="/user/password" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/password' }">
            <i class="glyphicon glyphicon-lock myicon-right"></i> {{navigationConfig.menus[8]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <router-link v-bind:to="`/users/${ user.id }`" class="list-group-item">
            <i class="glyphicon myicon-right fa fa-tags" aria-hidden="true"></i> {{navigationConfig.menus[9]}}
        </router-link> <!-- **** ./ list-group-item **** -->

        <router-link to="/user/company" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/company' }">
            <i class="fa fa-building myicon-right"></i> {{navigationConfig.menus[10]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <router-link v-if="user.i_am.includes('0')" to="/user/bank" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/bank' }">
            <i class="fa fa-bank myicon-right"></i> {{navigationConfig.menus[11]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <router-link to="/user/sold-packages" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/sold-packages' }">
            <i class="myicon-right"></i> {{navigationConfig.menus[12]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <router-link to="/user/ordered-packages" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/ordered-packages' }">
            <i class="myicon-right"></i> {{navigationConfig.menus[13]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
        <router-link to="/user/packages" class="list-group-item" v-bind:class="{ 'active': this.$route.path === '/user/packages' }">
            <i class="myicon-right"></i> {{navigationConfig.menus[14]}}
                    <span class="pull-right">
                    <i class="fa fa-chevron-right "></i>
                    </span>
        </router-link> <!-- **** ./ list-group-item **** -->
    </div>
</template>

<script type="text/babel">
    export default {
         data() {
            return {
                navigationConfig: {}
            }
        },
        created() {
            this.fetchContentEn();
        },
        computed: {
            user() {
                return this.$store.getters.user;
            }
        },
        methods: {
            fetchContentEn() {
                this.$http.get('/data/content_en.json').then(response => {
                    this.navigationConfig = response.body.account_navigation;
                }, response => {
                    console.log(response);
                });
            }
        }
    }
</script>