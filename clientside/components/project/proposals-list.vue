<template>
    <div>
        <send-proposal v-if="! loading && auth === true && project && project.status === 'opened' && ! project.applied && project.author_id !== user.id"
                       v-bind:project="project"
                       v-on:proposalCreated="onProposalCreated"
        ></send-proposal>

        <h4 class="comments-title" id="commentsGrid">
            <span class="fa fa-comment myicon-right color-strong"></span>
            Proposals ({{ project.proposals.length }})
        </h4>
        <hr>
        <div class="col-thumb">
            <div v-for="proposal in sortedProposals()" class="media media-comments position-relative">
                <span class="pull-left">
                    <router-link v-bind:to="`/users/${ proposal.user_id }`">
                        <img width="50" height="50" class="media-object img-circle" v-bind:src="proposal.author.avatar_path">
                    </router-link>
                    <span v-if="proposal.author.rating" style="color:green; font-size:11px; margin-left:10px;">
                        {{ proposal.author.rating / 5 * 100 }}%
                    </span>
                    <span v-else style="font-size:11px; margin-left:10px;">
                        N/A
                    </span>
                </span>
                <div class="media-body media-body-comments">
                    <span v-if="! loading && auth && project.author_id === user.id"
                          class="pull-right"
                          v-cloak
                    >
                        Offer {{ `${ proposal.offer } €` }} 
                        <router-link v-if="contact" v-bind:to="contact">Contact</router-link>
                        <!-- <a v-on:click="acceptProposal(proposal)" href="javascript:void(0)">Accept</a> -->
                    </span>
                    <span v-if="proposal.status === 'accepted'" class="pull-right">
                        Accepted
                    </span>
                    <h4 class="media-heading col-thumb">
                        <router-link class="text-decoration-none" v-bind:to="`/users/${ proposal.author_id }`" v-cloak>
                            {{ proposal.author.first_name }}
                            {{ proposal.author.last_name }}
                        </router-link>
                    </h4>
                    <p class="comments-p mentions-links">{{ proposal.message || 'Confidential' }}</p>
                    <div class="btn-block"><small class="timeAgo small-comment">{{ proposal.created_at | moment('from') }}</small></div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import sendProposal from './send-proposal.vue';

    export default {
        methods: {
            acceptProposal(proposal) {
                this.$http.post(`/api/proposals/${ proposal.id }/accept`).then(response => {
                    this.project.status = 'closed';
                    proposal.status = 'accepted';
                });
            },
            onProposalCreated(proposal) {
                this.project.applied = true;
                this.project.proposals.unshift(proposal);
            },
            sortedProposals() {
                if(this.project.proposals.length === 0) {
                    return [];
                }

                return this.project.proposals.slice().sort(function(a, b) {
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
            'send-proposal': sendProposal
        },
        props: ['project', 'loading', 'contact']
    }
</script>