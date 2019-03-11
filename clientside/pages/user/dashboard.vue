<template>
    <div class="container wrap-ui packages-container my-packages content-wrapper">
        <div class="row">
            <div class="col-md-4">
                <div class="responsive-side collapse">
                    <user-overview v-bind:data="auth"></user-overview>
                    <account-navigation></account-navigation>
                    <ad></ad>
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="content">
                        <ul>
                            <li>
                                <router-link to="/user/projects">{{navigationConfig.menus[1]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/prospected">{{navigationConfig.menus[2]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/startups">{{navigationConfig.menus[3]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/startup-prospected">{{navigationConfig.menus[4]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/messages">{{navigationConfig.menus[5]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/profile">{{navigationConfig.menus[6]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/avatar">{{navigationConfig.menus[7]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/password">{{navigationConfig.menus[8]}}</router-link>
                            </li>
                            <li>
                                <router-link v-bind:to="`/users/${auth.id}`">{{navigationConfig.menus[9]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/company">{{navigationConfig.menus[10]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/bank">{{navigationConfig.menus[11]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/sold-packages">{{navigationConfig.menus[12]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/ordered-packages">{{navigationConfig.menus[13]}}</router-link>
                            </li>
                            <li>
                                <router-link to="/user/packages">{{navigationConfig.menus[14]}}</router-link>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import accountNavigation from '../../components/account-navigation.vue';
    import ad from '../../components/ad.vue';
    import userOverview from '../../components/user-overview.vue';

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
            auth() {
                return this.$store.getters.user
            }
        },
        components: {
            'ad': ad,
            'account-navigation': accountNavigation,
            'user-overview': userOverview
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
<style>
.packages-container .btn-wrapper {
    float: right;
}
.packages-container .create-package-btn {
    width: 100%;
}

.my-packages .title {
    width: 64% !important;
}
</style>