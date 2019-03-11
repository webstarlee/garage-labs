<template>
    <div class="container wrap-ui content-wrapper" v-if="auth">
        <!-- ROW -->
        <div class="row">
            <div class="col-md-4">
                <div class="responsive-side collapse">
                    <user-overview v-bind:data="auth" v-bind:loading="loading"></user-overview>
                    <account-navigation></account-navigation>
                    <ad></ad>
                </div>
            </div>
            <div class="col-md-8">
                <!--********* panel panel-default ***************-->
                <div class="panel panel-default">
                    <div class="panel-heading grid-panel-title" style="padding-left: 0px;">
                        <span class="btn-block">
                        <img src="/vendor/img/notification-bell.png" />
                        Notifications
                        </span><!-- **btn-block ** -->
                    </div>
                    <!-- ** panel-heading ** -->
                    <div class="content">
                        <li>
                            <ul  class="notifications-list" role="menu">
                                <li v-for="notification in notifications" class="notification-item">
                                    <div class="left">
                                        <template v-if="notification.link !== null">
                                            <a class="content notification-row" v-bind:href="`${ notification.link }`">
                                                <strong>{{ notification.title }}</strong>
                                                <p>{{ notification.message }}</p>
                                            </a>
                                        </template>
                                        <template v-else>
                                            <div class="content notification-row">
                                                <strong>{{ notification.title }}</strong>
                                                <p>{{ notification.message }}</p>
                                            </div>
                                        </template>
                                    </div>
                                    <div class="history">
                                        <span>
                                            <img src="/vendor/img/clock.png" />
                                            {{notification.created_at | moment('YYYY-MM-DD')}}
                                        </span>
                                    </div>
                                    <div>
                                        <a href="javascript:void(0);" v-on:click="removeNotification(notification.id)">
                                            <img src="/vendor/img/close.png" />
                                        </a>
                                    </div>
                                </li>
                                <li class="text-center" v-if="! notificationsLoading && notifications.length === 0">
                                    <p class="text-grey content">No notification</p>
                                </li>
                                <li class="text-center" v-if="notificationsLoading">
                                    <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
                                </li>
                            </ul>
                        </li>
                        <li v-if="loading" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></li>
                        <li v-if="notifications.length === 0 && loading === false">
                            <p style="padding: 20px; text-align: center; color: #9c9c9c; font-size: 120%;">You do not have a message yet.</p>
                        </li>
                        <div v-show="!notificationsLoading && next_page_url && next_page_url.length" class="btn-group paginator-style">
                            <div class="btn-group paginator-style">
                                <ul class="pager">
                                    <li><a href="javascript:void(0)" v-on:click="fetchNotifications()" rel="next"><i class="glyphicon glyphicon-chevron-down"></i></a></li>
                                </ul>
                            </div>
                        </div>
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

    export default {
        data() {
            return {
                notifications: [],
                notificationsLoading: true,
                next_page_url: '/api/notifications/all'
            }
        },
        created() {
            setTimeout(() => {
                this.fetchNotifications();
            }, 0);
        },
        methods: {
             fetchNotifications() {
                this.notificationsLoading = true;

                this.$http.get(this.next_page_url).then(response => {
                    this.notifications = this.notifications.concat(response.data.data);
                    this.next_page_url = response.data.next_page_url;
                }).finally(() => {
                    this.notificationsLoading = false;
                });
            },
            removeNotification(id) {
                this.notificationsLoading = true;

                this.$http.post('/api/notifications/remove', {id: id, type: 'all'}).then(response => {
                    this.notifications = response.data.data;
                    this.next_page_url = '/api/notifications/all';
                }, error => {
                    alert(response.data);
                }).finally(() => {
                    this.notificationsLoading = false;
                });
            }
        },
        computed: {
            auth() {
                return this.$store.getters.user;
            }
        },
        components: {
            ad,
            'account-navigation': accountNavigation,
            'user-overview': userOverview
        }
    }
</script>
<style scoped>

    .navbar-inverse .navbar-nav > .open > .dropdown-menu.notifications-list {
        padding: 0;
        border: none;
    }

    .navbar-inverse .navbar-nav > .open > .dropdown-menu > li > a {
        padding: 0;
    }

    .navbar-inverse .navbar-nav > .user.open > .dropdown-menu > li > a {
        padding: 6px 10px;
    }

    .notifications-list li a {
        padding: 0;
        white-space: pre-wrap;
        white-space: -moz-pre-wrap;
        white-space: -pre-wrap;
        white-space: -o-pre-wrap;
        word-wrap: break-word;
    }

    .notifications-list li p.content {
        padding: 6px 15px;
    }

    .dropdown-menu li > a:before, .dropdown-menu li > a:after {
        content: '';
    }

    .notifications-list p {
        margin: 0;
    }

    .navbar-toggle {
        margin:0;
    }

    .notification-row:hover {
        color: #FFD700 !important;
    }

    .notification-item {
        display: flex;
        align-items: center;
        padding-left: 10px;
        border-bottom: 1px solid #ddd;
        padding: 10px 0;
    }

    .notification-item .left {
        width: 70%;
    }

    .see-all-wrapper {
        text-align: center;
        padding-bottom: 15px;
    }

    .see-all-wrapper a {
        color: blue !important;
    }

    .see-all-wrapper a:hover {
        color: #FFD700 !important;
    }
    
    .history {
        width: 20%;
    }
</style>