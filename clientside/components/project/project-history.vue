<template>
    <div>
        <!-- Modal -->
        <div id="offerModal" class="modal fade" role="dialog" v-if="auth && user.id !== proposal.project.author_id">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">MODIFY MY OFFER</h4>
                    </div>
                    <div class="modal-body">
                        <div v-if="auth" class="panel panel-default">
                            <div class="position-relative">
                                <div class="btn-block">
                                    <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                                        <form v-on:submit.prevent="updateOffer()">
                                            <fieldset v-bind:disabled="loading">
                                                <div class="form-group" v-bind:class="{ 'has-error': errors.message !== undefined }">
                                                    <input v-model="offer" class="form-control" placeholder="300€" type="number" min="1" />
                                                    <p v-if="errors.message !== undefined" class="help-block">{{ errors.message.join() }}</p>
                                                </div>
                                                <div class="form-group">
                                                    <button data-toggle="modal" class="ns-btn ns-btn-yel" style="width: 100%;">
                                                        SUBMIT MY OFFER
                                                    </button>
                                                    <div v-if="submitting" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></div>
                                                </div>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="alert alert-warning text-center" role="alert">
                            You must be logged in to apply <router-link to="/login">Identify me</router-link>
                            - <router-link to="/register">Register</router-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-default" v-if="auth" v-cloak>
            <div class="panel-heading grid-panel-title">
                <span class="btn-block">
                Project History
                </span><!-- **btn-block ** -->
            </div>
            <!-- ** panel-heading ** -->
            <div class="content" >
                <li class="li-group-msg hoverList" >
                    <div class="media">
                        <div class="media-body clearfix">
                            <p class="text-col">
                                <small>Project: {{ proposal.project.title }}</small>
                            </p>
                            <p class="text-col" 
                                v-if="proposal.project.status === 'opened'
                                    && user.id !== proposal.project.author_id
                                    && proposal.status !== 'accepted'">
                                <small>{{proposal.author.name}} offered : {{proposal.offer}}€ (<span class="highlight-text"> accepted by {{proposal.project_author.name}}</span>)</small>
                                <a href="javascript:void(0);" v-on:click="openOfferModal()" class="modify-offer-link">Modify my offer</a>
                            </p>
                             <p class="text-col" 
                                v-if="proposal.project.status === 'opened' 
                                    && user.id === proposal.project.author_id
                                    && proposal.status !== 'accepted'
                                    && !accept">
                                <small>{{proposal.author.name}} offered : {{proposal.offer}}€</small>
                                <button v-on:click="acceptProposal()" class="ns-btn ns-btn-yel pull-right accept-offer-btn" style="width: 200px;">ACCEPT THE OFFER</button>
                            </p>

                             <p class="text-col" 
                                v-if="(proposal.project.status === 'closed' 
                                    && user.id === proposal.project.author_id
                                    && proposal.status === 'accepted') || displayMilestoneButton" v-cloak>
                                <small>{{proposal.author.name}} offered : {{proposal.offer}}€ (<span class="highlight-text"> accepted by {{proposal.project_author.name}}</span>)</small>
                                <router-link :to="{path: `/projects/milestone/${proposal.id}`, query: { title: proposal.project.title, owner:  proposal.project_author.name, supplier: proposal.author.name, offer: proposal.offer, author_id: proposal.project.author_id}}" class="ns-btn ns-btn-yel pull-right accept-offer-btn" style="width: 250px;">CREATE A MILESTONE</router-link>
                            </p>

                            <p class="text-col" 
                                v-if="(proposal.project.status === 'closed' 
                                    && user.id === proposal.project.author_id
                                    && proposal.status === 'accepted') || displayMilestoneButton" v-cloak>
                                <router-link :to="{path: `/projects/milestone/owner/management/${proposal.id}`}" class="ns-btn ns-btn-yel pull-right accept-offer-btn" style="width: 250px;">MILESTONE MANAGEMENT</router-link>
                            </p>

                            <p class="text-col" 
                                v-if="(proposal.project.status === 'closed' 
                                    && user.id === proposal.author_id
                                    && proposal.status === 'accepted') || displayMilestoneButton" v-cloak>
                                <router-link :to="{path: `/projects/milestone/management/${proposal.id}`}" class="ns-btn ns-btn-yel pull-right accept-offer-btn" style="width: 250px;">MILESTONE MANAGEMENT</router-link>
                            </p>
                             <!-- <p class="text-col" 
                                v-if="proposal.project.status !== 'opened' 
                                    && user.id === proposal.project.author_id
                                    && proposal.status === 'accepted'
                                    && !approved">
                                <small>{{proposal.author.name}} offered : {{proposal.offer}}€</small>
                                <button v-on:click="approveProposal()" class="ns-btn ns-btn-yel pull-right accept-offer-btn" style="width: 200px;">APPROVED THE OFFER</button>
                            </p> -->
                        </div>
                </div>
                </li>
                <li v-if="loading" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></li>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
export default {
  props: ["proposal", "loading"],
  data() {
    return {
      offer: null,
      errors: {},
      accept: false,
      approved: false,
      submitting: false,
      displayMilestoneButton: false
    };
  },
  computed: {
    auth() {
      return this.$store.getters.auth;
    },
    user() {
      return this.$store.getters.user;
    }
  },
  created() {
    this.$events.on(
      "acceptProposalCompletely",
      this.displayCreatingMilestoneButton
    );
  },
  methods: {
    updateOffer() {
      this.submitting = true;
      this.errors = {};

      this.$http
        .post(`/api/proposals/${this.proposal.id}/modify-offer`, {
          project_id: this.proposal.project.id,
          offer: this.offer
        })
        .then(
          response => {
            this.proposal.offer = this.offer;
            $("#offerModal").modal("hide");
          },
          response => {
            this.errors = response.data;
          }
        )
        .then(() => {
          this.submitting = false;
        });
    },
    openOfferModal() {
      this.offer = this.proposal.offer;
      $("#offerModal").modal("show");
    },
    acceptProposal() {
      this.accept = true;
      this.$events.emit("acceptProposalFired");
    },
    displayCreatingMilestoneButton() {
      this.displayMilestoneButton = true;
    }
    // approveProposal() {
    //     this.approved = true;
    //     this.$events.emit('approveProposalFired');
    // }
  }
};
</script>


<style scoped>
.content {
  max-height: 300px;
  overflow-y: scroll;
  margin-left: 15px;
}

.modify-offer-link {
  margin-left: 20px;
}

.accept-offer-btn {
  margin-right: 10px;
}
</style>