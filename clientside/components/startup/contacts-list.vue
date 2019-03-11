<template>
    <div>
      <send-contact   v-if="!loading && auth === true && startup && startup.author_id !== user.id"
                      v-bind:startup="startup"
                      v-on:contactCreated="oncontactCreated">
      </send-contact>

        <hr>
        <div class="col-thumb">
            <div v-for="contact in sortedContacts()" v-bind:key="contact.id" class="media media-comments position-relative">
                <span class="pull-left" v-if="!loading && auth === true && startup && startup.author_id === user.id">
                    <router-link v-bind:to="`/users/${ contact.user_id }`">
                        <img width="50" height="50" class="media-object img-circle" v-bind:src="contact.author.avatar_path">
                    </router-link>
                    <span v-if="contact.author.rating" style="color:green; font-size:11px; margin-left:10px;">
                        {{ contact.author.rating / 5 * 100 }}%
                    </span>
                    <span v-else style="font-size:11px; margin-left:10px;">
                        N/A
                    </span>
                </span>
                <div class="media-body media-body-comments" v-if="!loading && auth === true && startup && startup.author_id === user.id">
                    <h4 class="media-heading col-thumb">
                        <router-link class="text-decoration-none" v-bind:to="`/users/${ contact.author_id }`" v-cloak>
                            {{ contact.author.first_name }}
                            {{ contact.author.last_name }}
                        </router-link>
                    </h4>
                    <p class="comments-p mentions-links" >{{ contact.message }}</p>
                    <!-- <p class="comments-p mentions-links"  v-if="!loading && auth === true && startup && startup.author_id !== user.id">Confidential</p> -->
                    <div class="btn-block">
                        <small class="timeAgo small-comment">{{ contact.created_at | moment('from') }}</small>
                        <span class="pull-right">
                            <template v-if="contact.id">
                                <router-link v-bind:to="'/user/messages/startup-thread/'+ contact.id" class="btn btn-success btn-sm">
                                    Reply
                                </router-link>
                            </template>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import sendcontact from './send-contact.vue';

    export default {
        methods: {
            oncontactCreated(contact) {
                this.startup.applied = true;
                this.startup.contacts.unshift(contact);
                this.$emit('contactSend', true);
            },
            sortedContacts() {
                if(!this.startup.contacts || this.startup.contacts.length === 0) {
                    return [];
                }

                return this.startup.contacts.slice().sort(function(a, b) {
                    return a.id < b.id ? 1 : 0;
                });
            }
        },
        computed: {
            auth: function() {
                return this.$store.getters.auth;
            },
            user: function() {
                return this.$store.getters.user;
            }
        },
        components: {
            'send-contact': sendcontact
        },
        props: ['startup', 'loading']
    }
</script>