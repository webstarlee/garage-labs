<template>
    <div v-if="auth" class="content-wrapper">
        <!-- Modal -->
        <div id="submitMilestoneModal" class="modal fade" role="dialog">
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
                                                     <textarea v-model="submitMilestone.description"
                                                                class="form-control input-sm"
                                                                style="height:200px;resize: none;"
                                                                placeholder="Describe the delivery"
                                                        ></textarea>
                                                        <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                                </div>
                                                <div class="form-group">
                                                    <label>Document(s)</label>
                                                    <div v-for="(attachment, index) in submitMilestone.attachments" class="form-group mb-0">
                                                        <div class="row">
                                                                <div class="col-sm-6 pl-0" style="margin-left: 20px;">
                                                                    <input type="file" @change="uploadAttachment(attachment, $event, index)" class="up_0">
                                                                    <p class="help-block"></p>
                                                                </div>
                                                                <div class="col-sm-4">
                                                                    <a id="up_0"
                                                                    @click="submitMilestone.attachments.splice(index, 1)"
                                                                    style="padding: 5px 10px;"
                                                                    class="delete_up pull-right btn btn-inverse btn-sm"
                                                                    value="remove"
                                                                    >X</a>
                                                                </div>
                                                            </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                   + <a href="javascript:void(0)" @click="submitMilestone.attachments.push({})"><u>Add a document</u></a>
                                                </div>
                                                <div class="form-group">
                                                    <button data-toggle="modal" class="ns-btn ns-btn-yel" style="width: 100%;margin-top: 10px">
                                                        SUBMIT FOR APPROVAL
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
                        INVOICE {{printMilestone.supplier_inv_id}} <br/>
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
                                                    <td>COMPANY: THE GARAGES LABS</td>
                                                    <td class="pull-right">COMPANY: {{company && company.name ? company.name : 'N/A'}}</td>
                                                </tr>
                                                 <tr>
                                                    <td>ADDRESS: 123/44 ABC street</td>
                                                    <td class="pull-right">ADDRESS: {{user.address ? user.address : 'N/A'}}</td>
                                                </tr>
                                                 <tr>
                                                    <td>CITY: ABC XYZ</td>
                                                    <td class="pull-right">CITY: {{user.city && user.city.name ? user.city.name : 'N/A'}}</td>
                                                </tr>
                                                <tr>
                                                    <td>COUNTRY: FRANCE</td>
                                                    <td class="pull-right">COUNTRY: {{user.country && user.country.name ? user.country.name : 'N/A'}}</td>
                                                </tr>
                                                <tr>
                                                    <td>VAT: ABCDEF1234567890</td>
                                                    <td class="pull-right">VAT: {{company && company.vat_number ? company.vat_number : 'N/A'}}</td>
                                                </tr>
                                                <tr>
                                                    <td>INCOPORATION NUMBER: ABCDEF1234567890</td>
                                                    <td class="pull-right">INCOPORATION NUMBER: {{company && company.incorporation_number ? company.incorporation_number : 'N/A'}}</td>
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
                                                    <td colspan="2">TOTAL: {{getTotalWithoutFee(printMilestone.price)}}€ (we removed our fee from there)</td>
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
                                <fieldset v-bind:disabled="submitting">
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
                                                <div class="col-sm-11">
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
                                            <div style="padding-top: 10px;">
                                                <div v-for="(r, i) in milestone.revision">
                                                    <div>Revision ({{i + 1}}) asked on {{r.updated_at | moment("Do MMMM YYYY")}}</div>
                                                    <div><pre>{{r.description}}</pre></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="form-group col-sm-11">
                                                <input  id="milestonePrice" v-bind:value="milestone.price+'€'" type="text" name="price" class="form-control input-sm" readonly />
                                            </div>
                                            <div class="form-group col-sm-11">
                                                <div v-if="milestone.status!=='new'" class="green-text">
                                                    <i class="fa fa-check-circle" aria-hidden="true"></i> Funded on {{milestone.funding_date | moment("DD/MM/YYYY")}}
                                                </div>
                                                <div v-if="milestone.status==='approved'">
                                                    <div class="green-text">
                                                    Delivery approved
                                                    </div>
                                                    <div>
                                                        <div>Bank transfer of {{milestone.price}}€ {{ isTransfered(milestone.funding_date) ? 'done' : 'planned' }}</div>
                                                        <div>On {{getTransferedMoneyDate(milestone.funding_date) | moment("DD MM YYYY")}}</div>
                                                        <div v-if="history.account">On account {{history.account}}</div>
                                                        <div v-if="!history.account && user.i_am.includes('0')">Plese <router-link to="/user/bank" style="text-decoration: underline;">setup</router-link> your bank account to receive money.</div>
                                                    </div>
                                                    <div v-if="milestone.supplier_inv_id">
                                                        <a href="javascript:void(0);" v-on:click="openPrintModal(index)" class="green-text">INVOICE {{milestone.supplier_inv_id}}</a>
                                                    </div>
                                                </div>
                                                <a v-if="milestone.status==='waiting' && history.supplier===user.username" class="ns-btn btn-success col-sm-3" href="javascript:void(0);" v-on:click="acceptMilestone(milestone)">
                                                    <template>
                                                    ACCEPT THE MILESTONE
                                                    </template>
                                                </a>
                                                <div v-if="milestone.submitting" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></div>
                                                <div v-if="milestone.status==='waiting' && history.supplier===user.username">
                                                    <small>* The amount will be blocked and released to the supplier only when you approve the milestone.</small>
                                                </div>
                                                <a v-if="milestone.status==='accepted' && history.supplier===user.username" class="ns-btn btn-success col-sm-3" href="javascript:void(0);" v-on:click="openSubmittingModal(milestone, index)" style="background-color:#f4d742" >
                                                    <template>
                                                    SUBMIT THE DELIVERY
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
  export default {
      data() {
          return {
            loading: false,
            errors: {},
            milestones: [],
            history: {},
            submitMilestone: {
                attachments: [{}],
                description: ''
            },
            submittingModalNo: 0,
            submitting: false,
            totalMilestone: 0,
            printMilestone: {},
            company: {}
          }
      },
      created() {
          this.loadMilestones();
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
            this.$http.get(`../../../api/proposals/milestone/management/${this.$route.params.id}`).then(response => {
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
        acceptMilestone(milestone) {
            this.loading = true;
            this.errors = {};
            this.submitting = true;
            milestone.submitting = true;

            this.$http.post(`/api/proposals/milestone/accept`, {
                milestone_id: milestone.id
            }).then(response => {
                milestone.status = response.body.status;
            }, response => {
                this.errors = response.data;
            }).then(() => {
                this.loading = false;
                this.submitting = false;
                milestone.submitting = false;
            });
        },
        openSubmittingModal(milestone, index) {
            this.loading = false;
            this.submitting = false;
            this.submittingModalNo = index + 1;
            $('#submitMilestoneModal').modal('show');
        },
        send(index) {
            this.submitting = true;
            var milestone = this.milestones[index];
            this.errors = {};

            this.$http.post(`/api/proposals/milestone/delivery`, {
                milestone_id: milestone.id,
                description: this.submitMilestone.description,
                attachments: this.submitMilestone.attachments
            }).then(response => {
                milestone.status = response.body.status;
                milestone.deliveries = response.body.deliveries;
                this.submitMilestone = {
                    attachments: [{}],
                    description: ''
                };

                $('#submitMilestoneModal').modal('hide');
            }, response => {
                this.errors = response.data;
            }).then(() => {
                this.loading = false;
                this.submitting = false;
            });
        },
        uploadAttachment(attachment, event, index) {
                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('attachment', file);
                this.loading = true;

                this.$http.post('/api/proposals/milestone/document/upload', data).then(response => {
                    this.submitMilestone.attachments[index].filename = response.body.filename;
                }, response => {
                    alert(response.body.attachment.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
                })
        },
        moment: function () {
            return moment();
        },
        getTransferedMoneyDate(funding_date) {
            if (funding_date === null) {
                return funding_date;
            }

            let f_date = new Date(funding_date);
            f_date.setDate(f_date.getDate() + 10);
            return f_date;
        },
        isTransfered(funding_date) {
            if (funding_date === null) {
                return false;
            }

            let now = new Date();
            return now > this.getTransferedMoneyDate(funding_date);
        },
        openPrintModal(index) {
            this.printMilestone = this.milestones[index];
            this.printMilestone.no = this.totalMilestone - index;
            $('#printModal').modal('show');
        },
        getTotalWithoutFee(price) {
            var p = parseFloat(parseFloat(price).toFixed(2));
            return p - 8.5 * p / 100;
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

    .green-text {
        color: green;
        font-weight: bold;
        text-align: center;
        margin-bottom: 10px;
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