<template>
    <div class="container wrap-ui content-wrapper">
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
                    <div class="panel-heading grid-panel-title">
                        <span class="btn-block">
                        Messages
                        </span><!-- **btn-block ** -->
                    </div>
                    <!-- ** panel-heading ** -->
                    <div class="content">
                        <li v-for="(thread, index) in threads" class="li-group-msg hoverList" v-bind:class="{ 'unread': (thread.status === false || thread.status === 0) && thread.incoming }">
                            <router-link v-bind:to="`messages/thread/${ thread.id }`" class="see_msg list-group-item border-group" v-if="thread.project_title">
                                <div class="media">
                                    <div class="pull-left">
                                        <img v-bind:src="thread.user_avatar_path" alt="Image" class="border-image-profile-2 media-object img-circle image-dropdown">
                                    </div>
                                    <div class="media-body clearfix">
                                        <div class="pull-right small">
                                            <span class="timestamp timeAgo myicon-right">{{ thread.created_at | moment('from') }}</span>
                                            <br><font color="green">{{ thread.project_budget }}€</font>
                                        </div>
                                        <div class="media-nowrap">
                                            <strong class="media-heading">{{ thread.user_username }}</strong> - {{ thread.project_title }}
                                        </div>
                                        <p class="text-col">
                                            <small><i class="icon-undo2 myicon-right"></i> {{ thread.text }}</small>
                                        </p>
                                    </div>
                                </div>
                            </router-link>
                            <router-link v-bind:to="`messages/startup-thread/${ thread.contact.id }`" class="see_msg list-group-item border-group" v-if="thread.contact && thread.contact.startup">
                                <div class="media">
                                    <div class="pull-left">
                                        <img v-bind:src="thread.sender_avatar_path" alt="Image" class="border-image-profile-2 media-object img-circle image-dropdown">
                                    </div>
                                    <div class="media-body clearfix">
                                        <div class="pull-right small">
                                            <span class="timestamp timeAgo myicon-right">{{ thread.created_at | moment('from') }}</span>
                                            
                                        </div>
                                        <div class="media-nowrap">
                                            <strong class="media-heading">{{ thread.sender_username }}</strong> - {{ thread.contact.startup.title }}
                                        </div>
                                        <p class="text-col">
                                            <small><i class="icon-undo2 myicon-right"></i> {{ thread.text }}</small>
                                        </p>
                                    </div>
                                </div>
                            </router-link>
                            <router-link v-bind:to="`ordered-contact/${ thread.ordered_package.id }`" class="see_msg list-group-item border-group" v-if="thread.ordered_package">
                                <div class="media">
                                    <div class="pull-left">
                                        <img v-bind:src="thread.sender_avatar_path" alt="Image" class="border-image-profile-2 media-object img-circle image-dropdown">
                                    </div>
                                    <div class="media-body clearfix">
                                        <div class="pull-right small">
                                            <span class="timestamp timeAgo myicon-right">{{ thread.created_at | moment('from') }}</span>
                                            <br><font color="green">{{ thread.ordered_package.package.price }}€</font>
                                        </div>
                                        <div class="media-nowrap">
                                            <strong class="media-heading">{{ thread.sender_username }}</strong> - {{ thread.ordered_package.package.service.title }}
                                        </div>
                                        <p class="text-col">
                                            <small><i class="icon-undo2 myicon-right"></i> {{ thread.text }}</small>
                                        </p>
                                    </div>
                                </div>
                            </router-link>
                        </li>
                        <li v-if="loading" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></li>
                        <li v-if="threads.length === 0 && loading === false">
                            <p style="padding: 20px; text-align: center; color: #9c9c9c; font-size: 120%;">You do not have a message yet.</p>
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

    export default {
        data() {
            return {
                threads: [],
                loading: true,
                histories: []
            }
        },
        created() {
            setTimeout(() => {
                this.fetch();
            }, 0);
        },
        methods: {
            fetch() {
                Promise.all([
                    this.$http.get('/api/messages/threads'),
                    this.$http.get('/api/messages/startups'),
                    this.$http.get('/api/messages/service')
                ]).then(responses => {
                    var projects = [];
                    var startups = [];
                    var services = [];

                    if (responses && responses.length > 0 && responses[0].body) {
                        projects = responses[0].body;
                    }

                    if (responses && responses.length > 1 && responses[1].body) {
                        startups = responses[1].body;
                    }

                    if (responses && responses.length > 2 && responses[2].body) {
                        services = responses[2].body;
                    }

                    var allMessages = projects.concat(startups).concat(services);
                    this.threads = this.sortMessages(allMessages);
                }, response => {
                    console.log(response);
                }).then(() => {
                    this.loading = false;
                });
            },
            sortMessages(messages) {
                if (!messages || messages.length === 0) {
                    return messages;
                }

                var len = messages.length;
                var unreadMessages = [];
                var readMessages = [];

                for (var i = 0; i < len; i++) {
                    if (!messages[i].status && messages[i].incoming) {
                        unreadMessages.push(messages[i]);
                        continue;
                    }

                    readMessages.push(messages[i]);
                }

                unreadMessages.sort(function(m1, m2){return new Date(m2.created_at) - new Date(m1.created_at)});
                readMessages.sort(function(m1, m2){return new Date(m2.created_at) - new Date(m1.created_at)});

                return unreadMessages.concat(readMessages);
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