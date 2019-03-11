<template>
    <div class="container wrap-ui packages-container content-wrapper">
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
                        <package-li-list v-bind:orderedPackages="packages"></package-li-list>

                        <li v-if="loading" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></li>
                        <li v-if="packages.length === 0 && loading === false">
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

    import packageLiList from '../../components/package/sold-li-list.vue';

    export default {
        data() {
            return {
                packages: [],
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
            'package-li-list': packageLiList
        },
        methods: {
            fetch() {
                this.loading = true;

                this.$http.get('/api/services/sold-packages').then(response => {
                    this.packages = response.data;
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
</style>