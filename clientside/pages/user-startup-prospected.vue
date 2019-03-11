<template>
    <div class="container wrap-ui content-wrapper">
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
                    <div class="panel-heading grid-panel-title">
                        <span class="btn-block">
                        Prospected Start-up
                        </span>
                    </div>
                    <div class="content">
                        <user-startup-li v-for="startup in startups" v-bind:data="startup" v-bind:key="startup.id"></user-startup-li>
                        <li v-if="loading" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></li>
                        <li v-if="startups.length === 0 && loading === false">
                            <p style="padding: 20px; text-align: center; color: #9c9c9c; font-size: 120%;">No project prospected..</p>
                        </li>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import accountNavigation from '../components/account-navigation.vue';
    import ad from '../components/ad.vue';
    import userOverview from '../components/user-overview.vue';
    import userStartupLi from '../components/project/li.vue';

    export default {
        data() {
            return {
                startups: [],
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
            'user-startup-li': userStartupLi
        },
        methods: {
            fetch() {
                this.loading = true;

                this.$http.get('/api/startups/applied').then(response => {
                    this.startups = response.data;
            }, error => {
                    console.log(error);
                }).finally(() => {
                    this.loading = false;
            });
            }
        }
    }
</script>