<template>
    <div v-if="auth && this.$route.query.author_id===user.id" v-cloak class="content-wrapper">
       <!-- Modal -->
        <div id="fundingModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title text-center">FUND A MILESTONE</h4>
                    </div>
                    <div class="modal-body">
                        <div v-if="auth" class="panel panel-default">
                            <div class="position-relative">
                                <div class="btn-block">
                                    <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                                        <form v-on:submit.prevent="fundMilestone()">
                                            <fieldset v-bind:disabled="submitting">
                                                <div class="form-group">
                                                    <div>#MILESTONE {{milestoneNo}} :</div>
                                                    <div>{{milestone.title}}</div>
                                                </div>
                                                <div class="form-group">
                                                    <div>PRICE : {{getPrice()}}€</div>
                                                    <div>FEES ({{ratting}}%): {{getFee()}}€</div>
                                                    <div>TOTAL : {{getPrice() + getFee()}}€</div>
                                                </div>
                                                 <div class="form-group" v-bind:class="{ 'has-error': errors.credit_card !== undefined && errors.credit_card.length }">
                                                    <div>CREDIT CARD :</div>
                                                    <div class="">
                                                        <select  
                                                            v-if="isLoadCard && cards && cards.length > 0" 
                                                            v-model="milestone.credit_card"
                                                            class="input-sm"
                                                            style="margin-bottom: 10px">
                                                            <option 
                                                            v-for="card in cards" 
                                                            v-bind:value="card.card_id" 
                                                            v-bind:key="card.id"
                                                            :selected="milestone.card_no == card.card_no ? 'selected' : ''">
                                                            {{ card.card_no }}
                                                            </option>
                                                        </select>
                                                        <!--p  v-if="isLoadCard">VISA {{milestone.card_no}}</p -->
                                                        <input  required v-model="milestone.credit_card" v-if="!isLoadCard" type="text" name="credit_card" class="form-control input-sm" placeholder="6777XXXXXXXXX" />
                                                        <p v-if="errors.credit_card !== undefined" class="help-block">{{ errors.credit_card.join() }}</p>
                                                    </div>
                                                    <a v-if="isLoadCard" href="javascript:void(0)"v-on:click="addNewCreditCard()"><u>+ Add a new credit card</u></a>
                                                </div>
                                                <div class="form-group" v-if="!isLoadCard">
                                                    <div class="row">
                                                        <div class="col-md-4" v-bind:class="{ 'has-error': errors.expired !== undefined && errors.expired.length }">
                                                            <label>Expired At</label>
                                                            <input required v-model="milestone.expired" class="form-control input-sm" placeholder="2017/09"/>
                                                            <p v-if="errors.expired !== undefined" class="help-block">{{ errors.expired.join() }}</p>
                                                        </div>
                                                        <div class="col-md-4 col-md-offset-4" v-bind:class="{ 'has-error': errors.cvc !== undefined && errors.cvc.length }">
                                                            <label>CVC</label>
                                                            <input required v-model="milestone.cvc" class="form-control input-sm" placeholder="123" />
                                                            <p v-if="errors.cvc !== undefined" class="help-block">{{ errors.cvc.join() }}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <button data-toggle="modal" class="ns-btn ns-btn-yel" style="width: 100%;">
                                                        SAVE & FUND THE MILESTONE
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

        <div class="container wrap-ui">
          <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
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
                                            <small>Project: {{ this.$route.query.title }}</small>
                                        </p>

                                        <p class="text-col">
                                            <small>{{this.$route.query.supplier}} offered : {{this.$route.query.offer}}€ (<span class="highlight-text"> accepted by {{this.$route.query.owner}}</span>)</small>
                                        </p>
                                    </div>
                            </div>
                        </li>
                    </div>
                </div>
            </div>
          </div>
          <div class="row">
              <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading grid-panel-title text-center">
                            <h4>PROJECT MILESTONES</h4>
                        </div>
                        <div class="panel-body">
                            <form  class="form-horizontal form-account" role="form" style="border-bottom: #b3b5b7 solid 1px; padding: 10px 0;">
                                <fieldset v-bind:disabled="loading">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                        <label>MILESTONE #{{milestoneNo}}</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-9">
                                            <div class="form-group" v-bind:class="{ 'has-error': errors.title !== undefined && errors.title.length }">
                                                <div class="col-sm-11">
                                                    <input  id='milestoneTitle' v-model="milestone.title" type="text" name="title" class="form-control input-sm" placeholder="Milestone’s title" />
                                                    <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                                </div>
                                            </div>
                                            <div class="form-group" v-bind:class="{ 'has-error': errors.description !== undefined && errors.description.length }">
                                                <div class="col-sm-11">
                                                    <textarea v-model="milestone.description"
                                                            class="form-control input-sm"
                                                            style="height: 100px;resize: none;"
                                                            placeholder="Description"
                                                    ></textarea>
                                                    <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                                </div>
                                            </div>
                                            <div class="form-group" v-bind:class="{ 'has-error': errors.deadline !== undefined && errors.deadline.length }">
                                                <div class="col-sm-11">
                                                    <div class="input-group input-group-sm">
                                                        <input id="deadlineId"
                                                            type="text"
                                                            placeholder="Deadline"
                                                        v-model="milestone.deadline"
                                                            v-datepicker="setDeadline"
                                                            class="form-control input-sm"
                                                            name="deadline"
                                                        />
                                                    </div>
                                                    <div class="clearfix"></div>
                                                    <p v-if="errors.deadline !== undefined" class="help-block">{{ errors.deadline.join() }}</p>
                                                </div>
                                            </div>
                                            <div>Document(s)</div>
                                            <div v-for="(attachment, index) in milestone.attachments" class="form-group mb-0">
                                                <div class="col-sm-11">
                                                    <div id="upload_inputs">
                                                        <div class="col-sm-5 pl-0">
                                                            <input type="file" @change="uploadAttachment(attachment, $event, index)" class="up_0">
                                                            <p class="help-block"></p>
                                                        </div>
                                                        <div class="col-sm-5">
                                                            <a id="up_0"
                                                            @click="milestone.attachments.splice(index, 1)"
                                                            style="padding: 5px 10px;"
                                                            class="delete_up pull-right btn btn-inverse btn-sm"
                                                            value="remove"
                                                            >X</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-11">
                                                    + <a href="javascript:void(0)" @click="milestone.attachments.push({})"><u>Add a document</u></a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group col-md-12 col-sm-11">
                                                <input  id="milestonePrice" v-model="milestone.price" type="number" min="0" name="price" class="form-control input-sm" placeholder="Price" />
                                                <p v-if="errors.price !== undefined" class="help-block">{{ errors.price.join() }}</p>
                                            </div>
                                            <div class="form-group col-md-12 col-sm-11">
                                                <a class="ns-btn btn-success col-sm-3" href="javascript:void(0);" v-on:click="openFundingModal()">
                                                    <template>
                                                    SAVE & FUND THE MILESTONE
                                                    </template>
                                                </a>
                                                <div>
                                                    <small>* The amount will be blocked and released to the supplier only when you approve the milestone.</small>
                                                </div>
                                                <div class="text-center">OR</div>
                                                <a class="ns-btn ns-btn-yel col-sm-3" href="javascript:void(0);" v-on:click="saveMilestone()">
                                                    <template>
                                                        SAVE THE MILESTONE
                                                    </template>
                                                </a>
                                                <div v-if="savingMilestone" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </fieldset>
                            </form>

                            <!--div class="form-group panel-body mb-0">
                                <div class="col-sm-offset-3 col-sm-9 pl-0">
                                    <button v-on:click="addNewMilestone()" class="ns-btn ns-btn-yel" style="width:250px; margin-right:10px;">
                                        <template>
                                            + ADD A NEW MILESTONE
                                        </template>
                                    </button>
                                </div>
                            </div -->
                        </div>
                    </div>
              </div>
          </div>
        </div>
    </div>
</template>

<script type="text/babel">
  export default {
      data() {
          return {
            loading: false,
            errors: {},
            milestone: {
                attachments: [{}],
                title: '',
                price: 0,
                deadline: '',
                credit_card: null
            },
            isLoadCard: false,
            submitting: false,
            updateCard: false,
            milestoneNo: 1,
            savingMilestone: false,
            ratting: 3.5,
            cards: []
          }
      },
      created() {
          this.loading = true;
            this.$http.get(`../../../api/proposals/milestone/no/${this.$route.params.id}`).then(response => {
                this.milestoneNo = response.data.no;
                this.fetchCreditCards();
            }, response => {
                this.milestoneNo = 1;
            }).then(() => {
                this.loading = false;
        });
      },
      computed: {
        auth() {
          return this.$store.getters.auth;
        },
        user() {
          return this.$store.getters.user;
        }
      },
      methods: {
        openFundingModal() {
            if (!this.milestone.title) {
                alert('Please filling the milestone title firstly.');
                $('#milestoneTitle').focus();
                return;
            }

            if (!this.milestone.price) {
                alert('Please filling the milestone price firstly.');
                $('#milestonePrice').focus();
                return;
            }

            this.updateCard = false;
            
            if (this.milestone.credit_card === null) {
                this.$http.get('/api/proposals/milestone/card').then(response => {
                    var card = response.body.card;
                    
                    if (card !== null) {
                        this.milestone.credit_card = card;
                        this.isLoadCard = true;
                        this.milestone.card_no = response.body.card_no;
                    }
                }, response => {
                    this.milestone.credit_card = null;
                    this.isLoadCard = false;
                }).then(() => {
                    $('#fundingModal').modal('show');
                });
            } else {
                $('#fundingModal').modal('show');
            }
        },
        setDeadline(val) {
           this.milestone.deadline = val;
        },
        fundMilestone() {
            this.submitting = true;
            this.errors = {};
            this.$http.post(`/api/proposals/${this.$route.params.id}/milestone/payment`, {
                price: this.getPrice(),
                fee: this.getFee(),
                credit_card: this.milestone.credit_card,
                expired: this.isLoadCard ? '2017/09' : this.milestone.expired,
                cvc: this.isLoadCard ? '123' : this.milestone.cvc,
                update_card: this.updateCard,
                description: this.milestone.description,
                deadline: this.milestone.deadline,
                attachments: this.milestone.attachments,
                title: this.milestone.title,
                proposal_id: this.$route.params.id
            }).then(response => {
                if (response.body.card !== null) {
                    this.milestone.credit_card = response.body.card;
                    this.isLoadCard = true;
                }

                this.milestone.attachments = [];
                this.milestone.title = '';
                this.milestone.price = 0;
                this.milestone.description = '';
                this.milestoneNo = this.milestoneNo + 1;
                $('#fundingModal').modal('hide');
                this.$router.push(`/projects/milestone/owner/management/${this.$route.params.id}`);
            }, response => {
                if (response.status === 402) {
                    this.errors.credit_card = [response.body.message];
                } else {
                    this.errors = response.body;
                }
               
            }).then(() => {
                this.submitting = false;
            });
        },
        addNewCreditCard() {
            this.isLoadCard = false;
            this.milestone.credit_card = null;
            this.updateCard = true;
        },
        getPrice() {
            var p = parseFloat(this.milestone.price);
            return parseFloat(p.toFixed(2));
        },
        getFee() {
            return parseFloat((this.getPrice() * this.ratting / 100).toFixed(2));
        },
        uploadAttachment(attachment, event, index) {
                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('attachment', file);
                this.loading = true;

                this.$http.post('/api/proposals/milestone/document/upload', data).then(response => {
                    this.milestone.attachments[index].filename = response.body.filename;
                }, response => {
                    alert(response.body.attachment.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
                })
        },
        saveMilestone() {
            this.submitting = true;
            this.savingMilestone = true;
            this.errors = {};
            this.$http.post(`/api/proposals/${this.$route.params.id}/milestone/save`, {
                price: this.getPrice(),
                fee: this.getFee(),
                description: this.milestone.description,
                deadline: this.milestone.deadline,
                attachments: this.milestone.attachments,
                title: this.milestone.title,
                proposal_id: this.$route.params.id
            }).then(response => {
                this.milestone.attachments = [];
                this.milestone.title = '';
                this.milestone.price = 0;
                this.milestone.description = '';
                this.milestoneNo = this.milestoneNo + 1;
                this.$router.push(`/projects/milestone/owner/management/${response.data.proposal_id}`);
            }, response => {
                this.errors = response.body;
               
            }).then(() => {
                this.submitting = false;
                this.savingMilestone = false;
            });
        },
        fetchCreditCards() {
            this.loading = true;
            this.$http.get('/api/users/credit-cards').then(response => {
                this.cards = response.data;
            }).finally(() => {
                this.loading = false;
            });
        }
      },
      components: {
      }
  }
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

    .left-wrapper {
        padding: 0 20px;
    }
</style>