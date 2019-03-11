<template>
    <div>
        <div v-if="! loading && found">
            <div class="jumbotron cover-user jumbotron-cover"
                 v-bind:style="`background: url('${ user.cover_path }') no-repeat center center #000;`"
            >
                <div class="container wrap-jumbotron ui-container-cover">
                    <div class="btn-block text-center">
                        <a href="index.html" class="position-relative">
                            <img v-bind:src="user.avatar_path" width="128" height="128" class="img-circle border-avatar-profile">
                        </a>
                    </div>
                    <h3 class="w_text">{{ user.username }}
                        <span class="label pro-badge"></span>
                    </h3>
                    <div class="btn-block text-center">
                        <div class="pos-relative block-div">
                            <button v-if="user.conversation_exists === true"
                                    v-on:click="fetchConversations()"
                                    title="Hire me"
                                    type="button"
                                    class="btn btn-default btn-more-lg btn-sm msgModal"
                                    data-error="Une erreur a été rencontrée"
                                    data-send="Envoyer le message"
                                    data-wait="Envoi en cours..."
                                    data-success="Envoyé avec succès"
                                    data-id="1"
                                    data-toggle="modal"
                                    data-target="#myModal"
                            >
                                <i class="fa fa-envelope"></i>
                            </button>
                        </div>
                        <div v-if="user.conversation_exists"
                             class="modal fade"
                             id="myModal"
                             tabindex="-1"
                             role="dialog"
                             aria-labelledby="myModalLabel"
                             aria-hidden="true"
                        >
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Fermer</span></button>
                                        <h5 class="modal-title text-left" id="myModalLabel">
                                            Envoyer un message | <strong>{{ user.username }}</strong>
                                            <i v-show="message.sending || fetchingConversations" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i>
                                        </h5>
                                    </div>
                                    <div class="modal-body text-left">
                                        <form v-on:submit.prevent>
                                            <fieldset v-bind:disabled="message.sending || fetchingConversations">
                                                <div class="form-group" v-bind:class="{ 'has-error': message.errors.conversation_id !== undefined }">
                                                    <label>Choose project <span class="text-danger">*</span></label>
                                                    <select v-model="message.conversation_id">
                                                        <option v-for="conversation in conversations" v-bind:value="conversation.id">{{ conversation.project.title }}</option>
                                                    </select>
                                                    <p v-if="message.errors.conversation_id !== undefined" class="help-block">{{ message.errors.conversation_id.join() }}</p>
                                                </div>
                                                <div class="form-group" v-bind:class="{ 'has-error': message.errors.text !== undefined }">
                                                    <label>Message <span class="text-danger">*</span></label>
                                                    <textarea v-model="message.text" class="form-control textarea-text" name="message" id="message" placeholder="Je souhaiterai vous inviter"></textarea>
                                                    <p v-if="message.errors.text !== undefined" class="help-block">{{ message.errors.text.join() }}</p>
                                                </div>
                                                <div v-if="message.text" class="counterBio">{{ message.text.length }}</div>
                                            </fieldset>
                                        </form>
                                    </div>
                                    <!-- modal-body -->
                                    <div class="modal-footer">
                                        <div class="alert alert-danger btn-sm text-left col-thumb" role="alert" id="errors" style="display:none;"></div>
                                        <button v-on:click="sendMessage()" class="btn btn-info btn-sm btn-sort pull-left">Envoyer un message</button>
                                        <button type="button" class="btn btn-default btn-sm btn-border pull-left" style="background: #333 !important; color: #FFF !important;" data-dismiss="modal">Annuler</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="pos-relative block-div">
                            <button type="button" class="btn btn-default btn-more-lg btn-sm dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-sort-desc"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-settings menu-settings" id="setting-actions">
                                <li><a href="javascript:void(0);" class="report_user_spam" data-id="1">Signaler l'utilisateur</a></li>
                            </ul>
                        </div>
                    </div>
                    <p class="subtitle-user">
                        <i class="glyphicon glyphicon-map-marker"></i>
                        <template v-if="user.city">
                            {{ user.city.name }}
                        </template>
                        <template v-if="user.country">
                            {{ user.country.name }}
                        </template>
                    </p>
                </div>
            </div>
            <nav class="navbar navbar-default margin-b-10 navbar-user-ui" role="navigation">
                <div class="container">
                    <div style="width: 100%; text-align: center;">
                        <ul class="nav nav-pills nav-user-profile">
                            <li v-bind:class="{ active: this.$route.path === `/users/${ this.$route.params.id }` }">
                                <router-link v-bind:to="`/users/${ $route.params.id }`">
                                    Portfolio <small class="btn-block sm-btn-size text-center counter-sm">{{ user.references_count }}</small>
                                </router-link>
                            </li>
                            <li v-bind:class="{ active: this.$route.path === `/users/${ this.$route.params.id }/feedbacks` }">
                                <router-link v-bind:to="`/users/${ $route.params.id }/feedbacks`">
                                    Feedbacks <small class="btn-block sm-btn-size text-center counter-sm">{{ user.feedbacks_count }}</small>
                                </router-link>
                            </li>
                            <li v-bind:class="{ active: this.$route.path === `/users/${ this.$route.params.id }/projects` }">
                                <router-link v-bind:to="`/users/${ $route.params.id }/projects`">
                                    Projects <small class="btn-block sm-btn-size text-center counter-sm">{{ user.projects_count }}</small>
                                </router-link>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <router-view v-bind:user="user" v-bind:found="found" v-bind:loading="loading"></router-view>
        </div>
        <div v-if="loading" class="text-center" style="padding: 150px 0 250px; font-size: 30px;">
            <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
        </div>
    </div>
</template>

<script type="text/babel">
    export default {
        data() {
            return {
                message: {
                    conversation_id: null,
                    text: null,
                    errors: {},
                    sending: false
                },
                conversations: null,
                user: null,
                loading: true,
                found: false,
                fetchingConversations: false
            }
        },
        created() {
            setTimeout(() => {
                this.fetch();
            }, 0);
        },
        computed: {
            auth() {
                return this.$store.getters.user;
            }
        },
        methods: {
            sendMessage() {
                this.message.sending = true;

                this.$http.post('/api/messages', {
                    conversation_id: this.message.conversation_id,
                    receiver_id: this.user.id,
                    text: this.message.text
                }).then(() => {
                    let elems = document.getElementsByClassName('modal-backdrop fade in');

                    for(let i = 0; i < elems.length; ++i) {
                        elems[i].parentNode.removeChild(elems[i]);
                    }

                    this.$router.push(`/user/messages/thread/${ this.message.conversation_id }`);
                }, response => {
                    if(response.status === 403) {
                        if(this.message.conversation_id === null) {
                            this.message.errors.conversation_id = ['Choose project'];
                        }
                    } else {
                        this.message.errors = response.data;
                    }
                }).finally(() => {
                    this.message.sending = false;
                });
            },
            fetchConversations() {
                if(this.conversations !== null) {
                    return;
                }

                this.fetchingConversations = true;

                this.$http.get(`/api/conversations?user_id=${ this.$route.params.id }`).then(response => {
                    this.conversations = response.data;
                }, response => {
                    console.log(response);
                }).finally(() => {
                    this.fetchingConversations = false;
                })
            },
            fetch() {
                this.$http.get(`/api/users/${ this.$route.params.id }`).then(response => {
                    this.user = response.data;
                    this.found = true;
                }, response => {
                    console.log(response);
                }).finally(() => {
                    this.loading = false;
                });
            }
        }
    }
</script>

<style scoped>
    .loader-container {
        padding: 200px 0;
        font-size: 30px;
    }

    .cover-user {
        padding-top: 26px !important;
        background-size: cover;
        position:relative;
        max-height: 350px;
        height: 340px;
    }
</style>