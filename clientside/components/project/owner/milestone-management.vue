<template>
    <div v-if="auth" class="content-wrapper">
       <!-- Modal -->
        <div id="askingRevisionModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title text-center">SUBMIT MILESTONE {{submittingModalNo}} DELIVERY</h4>
                    </div>
                    <div class="modal-body">
                        <div v-if="auth" class="panel panel-default">
                            <div class="position-relative">
                                <div class="btn-block">
                                    <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                                        <form v-on:submit.prevent="send(submittingModalNo - 1)">
                                            <fieldset v-bind:disabled="submitting">
                                                <div class="form-group" v-bind:class="{ 'has-error': errors.description !== undefined && errors.description.length }">
                                                     <textarea v-model="revision.description"
                                                                class="form-control input-sm"
                                                                style="height:200px;resize: none;"
                                                                placeholder="Describe the revisions"
                                                        ></textarea>
                                                        <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                                </div>
                                                <div class="form-group">
                                                    <button data-toggle="modal" class="ns-btn ns-btn-yel" style="width: 100%;margin-top: 10px">
                                                        SUBMIT THE REVISIONS
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
                            Vous devez être connecté pour postuler <router-link to="/login">M'identifier</router-link>
                            - <router-link to="/register">M'inscrire</router-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="feedbackModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title text-center">MY FEEDBACK</h4>
                    </div>
                    <div class="modal-body">
                        <div v-if="auth" class="panel panel-default">
                            <div class="position-relative">
                                <div class="btn-block">
                                    <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                                        <form v-on:submit.prevent="sendFeedback()">
                                            <fieldset v-bind:disabled="submitting">
                                                <div class="form-group" v-bind:class="{ 'has-error': errors.message !== undefined && errors.message.length }">
                                                     <textarea v-model="feedback.message"
                                                                class="form-control input-sm"
                                                                style="height:200px;resize: none;"
                                                                placeholder="My feedback"
                                                        ></textarea>
                                                        <p v-if="errors.message !== undefined" class="help-block">{{ errors.message.join() }}</p>
                                                </div>
                                                <div class="rating-wrapper">
                                                    <div class="rating-label">Communication</div>
                                                    <div class="star">
                                                        <star-rating v-bind:star-size="25" v-bind:show-rating="false" v-model="feedback.communication"></star-rating>
                                                    </div>
                                                </div>
                                                <div class="rating-wrapper">
                                                    <div class="rating-label">Skills</div>
                                                    <div class="star">
                                                        <star-rating v-bind:star-size="25" v-bind:show-rating="false" v-model="feedback.skill"></star-rating>
                                                    </div>
                                                </div>
                                                <div class="rating-wrapper">
                                                    <div class="rating-label">Deadline respect</div>
                                                    <div class="star">
                                                        <star-rating v-bind:star-size="25" v-bind:show-rating="false" v-model="feedback.deadline"></star-rating>
                                                    </div>
                                                </div>
                                                <div class="rating-wrapper">
                                                    <div class="rating-label">Global experience</div>
                                                    <div class="star">
                                                        <star-rating v-bind:star-size="25" v-bind:show-rating="false" v-model="feedback.experience"></star-rating>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <button data-toggle="modal" class="ns-btn ns-btn-yel" style="width: 100%;margin-top: 10px">
                                                        SUBMIT MY FEEDBACK
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
                            Vous devez être connecté pour postuler <router-link to="/login">M'identifier</router-link>
                            - <router-link to="/register">M'inscrire</router-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>

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
                                                    <div>#MILESTONE {{currentMilestone.no}} :</div>
                                                    <div>{{currentMilestone.title}}</div>
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
                                                            v-model="currentMilestone.credit_card"
                                                            class="input-sm"
                                                            style="margin-bottom: 10px">
                                                            <option 
                                                            v-for="card in cards" 
                                                            v-bind:value="card.card_id" 
                                                            v-bind:key="card.id"
                                                            :selected="currentMilestone.card_no == card.card_no ? 'selected' : ''">
                                                            {{ card.card_no }}
                                                            </option>
                                                        </select>
                                                        <!-- p  v-if="isLoadCard">VISA {{currentMilestone.card_no}}</p -->
                                                        <input  required v-model="currentMilestone.credit_card" type="text" name="credit_card" class="form-control input-sm" placeholder="6777XXXXXXXXX" v-if="!isLoadCard" />
                                                        <p v-if="errors.credit_card !== undefined" class="help-block">{{ errors.credit_card.join() }}</p>
                                                    </div>
                                                    <a v-if="isLoadCard" href="javascript:void(0)"v-on:click="addNewCreditCard()"><u>+ Add a new credit card</u></a>
                                                </div>
                                                <div class="form-group" v-if="!isLoadCard">
                                                    <div class="row">
                                                        <div class="col-md-4" v-bind:class="{ 'has-error': errors.expired !== undefined && errors.expired.length }">
                                                            <label>Expired At</label>
                                                            <input required v-model="currentMilestone.expired" class="form-control input-sm" placeholder="2017/09"/>
                                                            <p v-if="errors.expired !== undefined" class="help-block">{{ errors.expired.join() }}</p>
                                                        </div>
                                                        <div class="col-md-4 col-md-offset-4" v-bind:class="{ 'has-error': errors.cvc !== undefined && errors.cvc.length }">
                                                            <label>CVC</label>
                                                            <input required v-model="currentMilestone.cvc" class="form-control input-sm" placeholder="123" />
                                                            <p v-if="errors.cvc !== undefined" class="help-block">{{ errors.cvc.join() }}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <button data-toggle="modal" class="ns-btn ns-btn-yel" style="width: 100%;">
                                                        FUND THE MILESTONE
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
                            Vous devez être connecté pour postuler <router-link to="/login">M'identifier</router-link>
                            - <router-link to="/register">M'inscrire</router-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="printModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closedPrintModal" type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title text-center">
                        INVOICE {{printMilestone.owner_inv_id}} <br/>
                        ESTABLISHED ON {{printMilestone.inv_created_at | moment("Do MMMM YYYY")}}
                        </h4>
                    </div>
                    <div class="modal-body">
                        <div v-if="auth" class="panel panel-default">
                            <div class="position-relative">
                                <div class="btn-block">
                                    <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                                        <table class="table-responsive print-table">
                                            <thead>
                                                <tr>
                                                    <th>CLIENT</th>
                                                    <th class="pull-right">SUPPLIER</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                 <tr>
                                                    <td>COMPANY: {{company && company.name ? company.name : 'N/A'}}</td>
                                                    <td class="pull-right">COMPANY: THE GARAGES LABS</td>
                                                </tr>
                                                 <tr>
                                                    <td>ADDRESS: {{user.address ? user.address : 'N/A'}}</td>
                                                    <td class="pull-right">ADDRESS: 123/44 ABC street</td>
                                                </tr>
                                                 <tr>
                                                    <td>CITY: {{user.city && user.city.name ? user.city.name : 'N/A'}}</td>
                                                    <td class="pull-right">CITY: ABC XYZ</td>
                                                </tr>
                                                <tr>
                                                    <td>COUNTRY: {{user.country && user.country.name ? user.country.name : 'N/A'}}</td>
                                                    <td class="pull-right">COUNTRY: FRANCE</td>
                                                </tr>
                                                <tr>
                                                    <td>VAT: {{company && company.vat_number ? company.vat_number : 'N/A'}}</td>
                                                    <td class="pull-right">VAT: ABCDEF1234567890</td>
                                                </tr>
                                                <tr>
                                                    <td>INCOPORATION NUMBER: {{company && company.incorporation_number ? company.incorporation_number : 'N/A'}}</td>
                                                    <td class="pull-right">INCOPORATION NUMBER: ABCDEF1234567890</td>
                                                </tr>
                                                <tr><br/></tr>
                                                <tr>
                                                    <td colspan="2">PROJECT: {{history.title}}</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">MILESTONE #{{printMilestone.no + ': ' + printMilestone.title}}</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">SUPPLIER - {{user.username}}</td>
                                                </tr>
                                                <tr><br/></tr>
                                                <tr>
                                                    <td colspan="2">TOTAL: {{getPriceWithFee(printMilestone.price)}}€ (we removed our fee from there)</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div v-else class="alert alert-warning text-center" role="alert">
                            Vous devez être connecté pour postuler <router-link to="/login">M'identifier</router-link>
                            - <router-link to="/register">M'inscrire</router-link>
                        </div>
                    </div>
                     <div class="modal-footer">
                        <button id="printButton" type="button" class="btn btn-success" v-on:click="print()">Print</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- End modal -->
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
                                            <small>Project: {{ history.title }}</small>
                                        </p>

                                        <p class="text-col"  v-for="h in history.histories">
                                            <small>{{h.description}}</small>
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
                            <form  class="form-horizontal form-account" role="form" style="border-bottom: #b3b5b7 solid 1px; padding: 10px 0;" v-for="(milestone, index) in milestones">
                                <fieldset v-bind:disabled="submitting" v-if="history.owner===user.username">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                        <label>MILESTONE #{{totalMilestone - index}}</label>
                                        </div>
                                    </div>
                                    <div class="row" v-if="isLate(milestone)">
                                        <div class="col-sm-12">
                                             <div class="form-group">
                                                <div class="col-sm-11">
                                                    <span class="ns-icon">
                                                        <img src="/vendor/img/late_alert.png" alt="">
                                                    </span>
                                                    <span>An issue with your order ? contact <router-link v-bind:to="`/customer-support/${milestone.id}/milestone`" class="underline-link">customer support</router-link></span>
                                                </div>
                                             </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-9">
                                            <div class="form-group">
                                                <div class="col-sm-11">
                                                    <input  id='milestoneTitle' v-bind:value="milestone.title" type="text" name="title" class="form-control input-sm" readonly />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-11">
                                                    <textarea v-bind:value="milestone.description"
                                                            class="form-control input-sm"
                                                            style="height: 100px;resize: none;"
                                                            placeholder="Description"
                                                            readonly
                                                    ></textarea>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-9">
                                                    <div class="input-group input-group-sm">
                                                        <input id="deadlineId"
                                                            type="text"
                                                            placeholder="Deadline"
                                                        v-bind:value="milestone.deadline"
                                                            class="form-control input-sm"
                                                            name="deadline"
                                                            readonly
                                                        />
                                                    </div>
                                                </div>
                                            </div>
                                            <div>
                                                <div>Document(s)</div>
                                                <div  class="form-group mb-0">
                                                    <div class="col-sm-11">
                                                    <a target="_blank"
                                                        v-for="document in milestone.documents"
                                                        v-bind:href="document.url"
                                                        class="btn-default btn-xs btn-border btn-block pull-left text-left fileContainer"
                                                        style="display: block; padding: 10px;"
                                                        >
                                                            <i style="font-size: 130%; margin-right: 5px;" class="fa fa-file" aria-hidden="true"></i>
                                                            <span class="myicon-right file-name-file">{{ document.filename }}</span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="padding-top: 10px;">
                                                <div v-for="(delivery, i) in milestone.deliveries">
                                                    <div>Delivery ({{i + 1}}) on {{delivery.updated_at | moment("Do MMMM YYYY")}}</div>
                                                    <div><pre>{{delivery.description}}</pre></div>
                                                    <div  class="form-group mb-0">
                                                        <div class="col-sm-11">
                                                        <a target="_blank"
                                                            v-for="document in delivery.documents"
                                                            v-bind:href="document.url"
                                                            class="btn-default btn-xs btn-border btn-block pull-left text-left fileContainer"
                                                            style="display: block; padding: 10px;"
                                                            >
                                                                <i style="font-size: 130%; margin-right: 5px;" class="fa fa-file" aria-hidden="true"></i>
                                                                <span class="myicon-right file-name-file">{{ document.filename }}</span>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group col-sm-11">
                                                <input  v-if="milestone.status!=='new'" v-bind:id="'milestonePrice' + index" v-bind:value="milestone.price+'€'" type="text" name="price" class="form-control input-sm" readonly />
                                                <input  v-if="milestone.status==='new'" v-bind:id="'milestonePrice' + index" v-model="milestone.price" type="text" name="price" class="form-control input-sm" />
                                            </div>
                                            <div class="form-group col-sm-11">
                                                <a v-if="milestone.status==='new'" class="ns-btn btn-success col-sm-3" href="javascript:void(0);" v-on:click="openFundingModal(index)">
                                                    <template>
                                                    FUND THE MILESTONE
                                                    </template>
                                                </a>
                                                 <div v-if="milestone.status!=='new'" class="green-text">
                                                    <i class="fa fa-check-circle" aria-hidden="true"></i> Funded on {{milestone.funding_date | moment("DD/MM/YYYY")}}
                                                </div>
                                                 <div v-if="milestone.status==='approved'" class="green-text">
                                                    Delivery approved
                                                </div>
                                                 <div v-if="milestone.supplier_inv_id">
                                                    <a href="javascript:void(0);" v-on:click="openPrintModal(index)" class="green-text">INVOICE {{milestone.supplier_inv_id}}</a>
                                                </div>
                                                <a v-if="milestone.status==='submitted'" class="ns-btn btn-success col-sm-3" href="javascript:void(0);" v-on:click="approveMilestone(milestone)" style="background-color:#f4d742">
                                                    <template>
                                                    APPROVE THE DELIVERY
                                                    </template>
                                                </a>
                                                <div v-if="milestone.submitting" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></div>
                                                <a v-if="milestone.status==='submitted'" class="ns-btn btn-success col-sm-3" href="javascript:void(0);" v-on:click="openAskingRevisionModal(index)" style="background-color:#5d5f63">
                                                    <template>
                                                    ASK FOR REVISION
                                                    </template>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
              </div>
          </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import starRating from 'vue-star-rating';

    export default {
      data() {
          return {
            loading: false,
            errors: {},
            milestones: [],
            history: {},
            revision: {
                description: ''
            },
            feedback: {
                message: '',
                communication: 0,
                skill: 0,
                deadline: 0,
                experience: 0
            },
            submittingModalNo: 0,
            submitting: false,
            updateCard: false,
            currentMilestone: {
                attachments: [{}],
                title: '',
                price: 0,
                deadline: '',
                credit_card: null,
                no: 1
            },
            totalMilestone: 0,
            printMilestone: {},
            company: {},
            isLoadCard: false,
            ratting: 3.5,
            cards: []
          }
      },
      created() {
          if (this.auth) {
            this.loadMilestones();
            this.fetchCreditCards();
          }
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
        loadMilestones() {
            this.loading = true;
            this.$http.get(`../../../../api/proposals/milestone/owner/management/${this.$route.params.id}`).then(response => {
                this.milestones = response.data.milestones;
                this.history = response.data.history;
                this.company = response.data.company;
                if (this.milestones) {
                    this.totalMilestone = this.milestones.length;
                }
            }, response => {
                this.milestones = [];
            }).then(() => {
                this.loading = false;
            });
        },
        approveMilestone(milestone) {
            this.loading = true;
            this.errors = {};
            this.submitting = true;
            milestone.submitting = true;
            this.$http.post(`/api/proposals/milestone/approve`, {
                milestone_id: milestone.id
            }).then(response => {
                milestone.status = response.body.status;
                $('#feedbackModal').modal('show');
            }, response => {
                this.errors = response.data;
            }).then(() => {
                this.loading = false;
                this.submitting = false;
                milestone.submitting = false;
            });
        },
        openAskingRevisionModal(index) {
            this.loading = false;
            this.submitting = false;
            this.submittingModalNo = index + 1;
            $('#askingRevisionModal').modal('show');
        },
        send(index) {
            this.submitting = true;
            var milestone = this.milestones[index];
            this.errors = {};

            this.$http.post(`/api/proposals/milestone/revision`, {
                milestone_id: milestone.id,
                description: this.revision.description
            }).then(response => {
                milestone.status = response.body.status;
                this.revision = {
                    description: ''
                };

                $('#askingRevisionModal').modal('hide');
            }, response => {
                this.errors = response.data;
            }).then(() => {
                this.loading = false;
                this.submitting = false;
            });
        },
        sendFeedback() {
            this.submitting = true;
            this.errors = {};
            this.loading = true;
            this.feedback.receiver_id = this.history.supplier_id;
            this.feedback.project_id = this.history.project_id;
            var totalRating = parseInt(this.feedback.communication) + parseInt(this.feedback.skill) + parseInt(this.feedback.deadline) + parseInt(this.feedback.experience);
            this.feedback.rating = Math.round(totalRating / 4);
            
            this.$http.post(`/api/feedbacks/proposal`, this.feedback).then(() => {
                this.feedback = {
                    message: '',
                    communication: 0,
                    skill: 0,
                    deadline: 0,
                    experience: 0
                };

                 $('#feedbackModal').modal('hide');
            }, response => {
                this.errors = response.data;
            }).finally(() => {
                this.loading = false;
                this.submitting = false;
            });
        },
        openFundingModal(index) {
            this.currentMilestone.no = index + 1;
            this.currentMilestone = $.extend(this.currentMilestone, this.milestones[index]);

            if (!this.currentMilestone.price || this.currentMilestone.price == 0) {
                alert('Please filling the milestone price firstly.');
                $('#milestonePrice' + index).focus();
                return;
            }

            this.updateCard = false;
            
            if (!this.currentMilestone.credit_card) {
                this.$http.get('/api/proposals/milestone/card').then(response => {
                    var card = response.body.card;
                    
                    if (card !== null) {
                        this.currentMilestone.credit_card = card;
                        this.isLoadCard = true;
                        this.currentMilestone.card_no = response.body.card_no;
                    }
                }, response => {
                    this.currentMilestone.credit_card = null;
                    this.isLoadCard = false;
                }).then(() => {
                    $('#fundingModal').modal('show');
                });
            } else {
                $('#fundingModal').modal('show');
            }
        },
        fundMilestone() {
            this.submitting = true;
            this.errors = {};
            this.$http.post(`/api/proposals/${this.$route.params.id}/milestone/payment`, {
                price: this.getPrice(),
                fee: this.getFee(),
                credit_card: this.currentMilestone.credit_card,
                expired: this.isLoadCard ? '2017/09' : this.currentMilestone.expired,
                cvc: this.isLoadCard ? '123' : this.currentMilestone.cvc,
                update_card: this.updateCard,
                description: this.currentMilestone.description,
                deadline: this.currentMilestone.deadline,
                attachments: this.currentMilestone.attachments,
                title: this.currentMilestone.title,
                proposal_id: this.$route.params.id,
                milestone_id: this.currentMilestone.id,
                printMilestone: {},
                company: {}
            }).then(response => {
                if (response.body.card !== null) {
                    this.currentMilestone.credit_card = response.body.card;
                    this.isLoadCard = true;
                    this.milestones[this.currentMilestone.no - 1].status = 'waiting';
                    this.milestones[this.currentMilestone.no - 1].funding_date = response.body.funding_date.date;
                }

                $('#fundingModal').modal('hide');
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
        getPrice() {
            return parseFloat(parseFloat(this.currentMilestone.price).toFixed(2));
        },
        getFee() {
            return parseFloat((parseFloat(this.currentMilestone.price) * this.ratting / 100).toFixed(2));
        },
        getPriceWithFee(price) {
            var p = parseFloat(price);
            return parseFloat(p.toFixed(2)) + parseFloat((p * this.ratting / 100).toFixed(2));
        },
         addNewCreditCard() {
            this.isLoadCard = false;
            this.currentMilestone.credit_card = null;
            this.updateCard = true;
        },
        openPrintModal(index) {
            this.printMilestone = this.milestones[index];
            this.printMilestone.no = this.totalMilestone - index;
            $('#printModal').modal('show');
        },
        print() {
            document.getElementById('printButton').style.display = 'none';
            document.getElementById('closedPrintModal').style.display = 'none';

            var prtContent = document.getElementById('printModal');
            var WinPrint = window.open('', '', 'left=0,top=0,width=800,height=900,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write('<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">');
            WinPrint.document.write('<style>td {font-size: 11px;line-height: 1.8;} .print-table {width: 100%;} @media (min-width: 768px) {.modal-dialog {width: 80%;}}</style>');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.setTimeout(function(){
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            }, 1000);

            document.getElementById('printButton').style.display = 'inline-block';
            document.getElementById('closedPrintModal').style.display = 'inline-block';
        },
        isLate(milestone) {     
            let now = new Date();
            let deadline = new Date(milestone.deadline);
            return milestone.status === 'waiting' && now > deadline;
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
          'star-rating': starRating
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

    .rating-wrapper {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .green-text {
        color: green;
        font-weight: bold;
        text-align: center;
    }

    .print-table {
        width: 100%;
    }

    .print-table td {
        text-transform: uppercase;
    }
    @media (min-width: 768px) {
        #printModal .modal-dialog {
            width: 80%;
        }
    }
</style>