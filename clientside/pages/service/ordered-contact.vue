<template>
    <div class="container wrap-ui content-wrapper">
        <!-- ROW -->
        <div class="row">
            <div class="col-md-4">
                <button type="button" class="btn btn-default btn-block btn-border btn-lg show-toogle" data-toggle="collapse" data-target=".responsive-side" style="margin-bottom: 20px;">
                    <i class="fa fa-bars"></i>
                </button>
                <div class="responsive-side collapse">
                    <user-overview v-bind:data="this.$store.getters.user"></user-overview>
                    <account-navigation></account-navigation>
                    <ad></ad>
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading grid-panel-title" style="overflow: auto">
                        <router-link to="/user/messages">Messages</router-link>
                        <span v-if="packageLoading">> {{ package.package.service.title }}</span>

                        <span class="pull-right"
                              v-cloak
                        >
                            Offre {{ `${ package.package.price } €` }} 
                        </span>
                    </div>
                    <div id="messages-thread" class="content" v-on:scroll="onScroll($event)">
                        <li v-if="fetching" class="media li-group list-group-item border-group text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></li>
                        <li v-for="(message, index) in messages" class="media li-group list-group-item border-group list-slimscroll chatlist margin-zero">
                            <div class="media">
                                <div class="pull-left">
                                    <router-link v-bind:to="`/users/${ message.sender_id }`">
                                        <div v-bind:style="{'background-image': getBackgroundImage(message.sender_avatar_path)}" class="message-avatar"></div>
                                        <!-- img width="40" v-bind:src="message.sender_avatar_path" alt="Image" class="border-image-profile-2 media-object img-circle" -->
                                    </router-link>
                                </div>
                                <div class="media-body clearfix">
                                    <div v-if="! message.incoming && message.read" class="pull-right small">
                                        <i class="glyphicon glyphicon-ok"></i>
                                    </div>
                                    <div class="pull-right small">
                                        <span class="timestamp timeAgo myicon-right">{{ message.created_at | moment('from') }}</span>
                                    </div>
                                    <div class="media-nowrap">
                                        <router-link v-bind:to="`/users/${ message.sender_id }`" class="text-decoration-none">
                                            <strong class="media-heading">{{ message.sender_username }}</strong>
                                        </router-link>
                                    </div>
                                    <p class="text-col paragraph none-overflow">{{ message.text }}</p>
                                    <p class="links-container" v-if="message.documents.length > 0">
                                        <a target="_blank"
                                           v-for="document in message.documents"
                                           v-bind:href="document.url"
                                           class="btn-default btn-xs btn-border btn-block pull-left text-left fileContainer"
                                        >
                                            <i style="font-size: 130%; margin-right: 5px;" class="fa fa-file" aria-hidden="true"></i>
                                            <span class="myicon-right file-name-file">{{ document.filename }}</span>
                                        </a>
                                    </p>
                                </div>
                            </div>
                        </li>
                        <li v-if="messages.length === 0 && ! fetching">
                            <p style="padding: 20px; text-align: center; color: #9c9c9c; font-size: 120%;">You do not have a message yet.</p>
                        </li>
                    </div>
                    <div class="panel-footer">
                        <div id="errors" class="alert alert-danger btn-sm text-left col-thumb display-none" role="alert"></div>
                        <div class="media">
                            <span href="#" class="pull-left">
                                <div v-bind:style="{'background-image': getBackgroundImage(user.avatar_path)}" class="message-avatar"></div>
                                <!-- img v-bind:src="user.avatar_path" class="media-object img-circle" width="40" height="40" -->
                            </span>
                            <div class="media-body">
                                <form v-on:submit.prevent="send()">
                                    <fieldset v-bind:disabled="loading">
                                        <div class="position-relative form-group" v-bind:class="{ 'has-error': errors.text !== undefined && errors.text.length }">
                                            <textarea v-model="message" class="form-control" rows="5"></textarea>
                                            <p v-if="errors.text && errors.text.length" class="help-block">{{ errors.text.join() }}</p>
                                            <div class="counterBio">1100</div>
                                        </div>
                                        <div class="form-group">
                                            <documents-upload v-bind:documents="documents"
                                                              v-on:addEmptyDocument="addEmptyDocument"
                                            />
                                        </div>
                                        <button type="submit" class="btn btn-info btn-sm btn-sort col-thumb">Envoyer</button>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import accountNavigation from '../../components/account-navigation.vue';
    import ad from '../../components/ad.vue';
    import userOverview from '../../components/user-overview.vue';
    import documentsUpload from '../../components/documents-upload.vue';

    export default {
        data() {
            return {
                package: null,
                fetching: true,
                documents: [],
                message: '',
                receiver_id: null,
                user: this.$store.getters.user,
                messages: [],
                initialLoading: true,
                packageLoading: true,
                next_page_url: `/api/services/messages/${ this.$route.params.id }`,
                loading: false,
                errors: {}
            }
        },
        computed: {
            auth() {
                return this.$store.getters.user
            }
        },
        created() {
            this.fetch();
             setTimeout(() => {
                this.getOrderedPackageById(this.$route.params.id);
            }, 0);
        },
        components: {
            ad,
            'documents-upload': documentsUpload,
            'account-navigation': accountNavigation,
            'user-overview': userOverview
        },
        methods: {
            getOrderedPackageById(id) {
                this.loading = true;

                this.$http.get(`/api/services/ordered-package/${id}`).then(response => {
                    this.package = response.data;
                    this.receiver_id = this.package.seller_id === this.user.id ? this.package.buyer_id : this.package.seller_id;
                }, error => {
                    console.log(error);
                }).finally(() => {
                    this.loading = false;
                });
            },
            addEmptyDocument() {
                this.documents.push({});
            },
            onScroll(event) {
                if(event.target.scrollTop !== 0 || this.next_page_url === null || this.fetching) {
                    return;
                }

                this.fetch();
            },
            send() {
                this.loading = true;
                this.errors = {};

                this.$http.post('/api/services/messages', {
                    ordered_package_id: this.package.id,
                    receiver_id: this.receiver_id,
                    text: this.message,
                    documents: this.documents
                }).then(response => {
                    this.messages.push({
                        receiver_id: this.receiver_id,
                        sender_id: this.user.id,
                        sender_avatar_path: this.user.avatar_path,
                        sender_username: this.user.username,
                        status: false,
                        text: response.data.text,
                        created_at: response.data.created_at,
                        documents: response.data.documents
                    });
                    this.message = '';
                    this.$nextTick(() => {
                        document.getElementById('messages-thread').scrollTop = document.getElementById('messages-thread').scrollHeight;
                    });
                }, error => {
                    if(error.status === 422) {
                        this.errors = error.data;
                    } else {
                        console.log(error);
                    }
                }).then(() => {
                    this.loading = false;
                });
            },
            fetch() {
                this.fetching = true;

                return this.$http.get(this.next_page_url).then(response => {
                    if (!response.data.data || response.data.data.length == 0) {
                        return;
                    }

                    response.data.data.reverse();

                    this.next_page_url = response.data.next_page_url;
                    this.messages = response.data.data.concat(this.messages);

                    if(this.initialLoading) {
                        this.$nextTick(() => {
                            document.getElementById('messages-thread').scrollTop = document.getElementById('messages-thread').scrollHeight;
                        });
                    }
                }, response => {
                    console.log(response);
                }).then(() => {
                    this.fetching = false;
                    this.initialLoading = false;
                });
            },
            getBackgroundImage(path) {
                return `url(${path})`;
            }
        }
    }
</script>

<style scoped>
    .content {
        max-height: 300px;
        overflow-y: scroll;
    }

    .links-container {
        margin-top: 15px;
    }

    .links-container a {
        margin-bottom: -6px;
    }

    .links-container a:last-child {
        margin-bottom: 5px;
    }

    .message-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-position: center;
        background-size: cover;
        background-repeat: no-repeat;
    }
</style>