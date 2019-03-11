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
                        <div class="row">
                            <div class="col-md-4 btn-wrapper">
                                <router-link class="ns-btn ns-btn-yel create-package-btn" to="/service/create">CREATE A SERVICE</router-link>
                            </div>
                        </div>
                        <package-li v-bind:services="services"></package-li>

                        <li v-if="loading" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></li>
                        <li v-if="services.length === 0 && loading === false">
                            <p style="padding: 20px; text-align: center; color: #9c9c9c; font-size: 120%;">No project created.</p>
                        </li>
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

    import packageLi from '../../components/package/li.vue';

    export default {
        data() {
            return {
                services: [],
                loading: true
            }
        },
        created() {
            setTimeout(() => {
                this.fetch();
            }, 0);
        },
        computed: {
            auth() {
                return this.$store.getters.user
            }
        },
        components: {
            'ad': ad,
            'account-navigation': accountNavigation,
            'user-overview': userOverview,
            'package-li': packageLi
        },
        methods: {
            fetch() {
                this.loading = true;

                this.$http.get('/api/services/my-services').then(response => {
                    this.services = response.data;
                }, error => {
                    console.log(error);
                }).finally(() => {
                    this.loading = false;
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