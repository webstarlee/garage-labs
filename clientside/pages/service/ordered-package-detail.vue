<template>
    <div class="content-wrapper">
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
          <div id="askingRevisionModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title text-center">ASK FOR REVISION</h4>
                    </div>
                    <div class="modal-body">
                        <div v-if="auth" class="panel panel-default">
                            <div class="position-relative">
                                <div class="btn-block">
                                    <div style="margin-left:15px; margin-top:10px; margin-right:12px">
                                        <form v-on:submit.prevent="sendAskRevision()">
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
                                                    <label>Document(s)</label>
                                                    <div v-for="(attachment, index) in revision.attachments" class="form-group mb-0">
                                                        <div class="row">
                                                                <div class="col-sm-6 pl-0" style="margin-left: 20px;">
                                                                    <input type="file" @change="uploadAttachment(attachment, $event, index)" class="up_0">
                                                                    <p class="help-block"></p>
                                                                </div>
                                                                <div class="col-sm-4">
                                                                    <a id="up_0"
                                                                    @click="revision.attachments.splice(index, 1)"
                                                                    style="padding: 5px 10px;"
                                                                    class="delete_up pull-right btn btn-inverse btn-sm"
                                                                    value="remove"
                                                                    >X</a>
                                                                </div>
                                                            </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                   + <a href="javascript:void(0)" @click="revision.attachments.push({})"><u>Add an attachment</u></a>
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
        
         <div id="printModal" class="modal fade" role="dialog"  v-if="auth && package.status==='approved'">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="closedPrintModal" type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title text-center">
                        INVOICE {{package.supplier_inv_id}} <br/>
                        ESTABLISHED ON {{package.inv_created_at.date ? package.inv_created_at.date : package.inv_created_at | moment("Do MMMM YYYY")}}
                        </h4>
                    </div>
                    <div class="modal-body" >
                        <div class="panel panel-default" v-if="auth">
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
                                                    <td class="pull-right">COMPANY: {{package.buyer.company && package.buyer.company.name ? package.buyer.company.name : 'N/A'}}</td>
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
                                                    <td class="pull-right">VAT: {{package.buyer.company && package.buyer.company.vat_number ? package.buyer.company.vat_number : 'N/A'}}</td>
                                                </tr>
                                                <tr>
                                                    <td>INCOPORATION NUMBER: ABCDEF1234567890</td>
                                                    <td class="pull-right">INCOPORATION NUMBER: {{package.buyer.company && package.buyer.company.incorporation_number ? package.buyer.company.incorporation_number : 'N/A'}}</td>
                                                </tr>
                                                <tr><br/></tr>
                                                <tr>
                                                    <td colspan="2">SERVICE: {{package.package.service.title}}</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">PACKAGE #{{package.id + ': ' + package.package.name}}</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">SUPPLIER - {{user.username}}</td>
                                                </tr>
                                                <tr><br/></tr>
                                                <tr>
                                                    <td colspan="2">TOTAL: {{getPriceWithFee(package.package.price)}}€</td>
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
        <div class="container wrap-ui ordered-package-detail">
            <div class="row">
                <div class="col-md-4">
                    <div class="responsive-side collapse">
                        <user-overview v-bind:data="auth"></user-overview>
                        <account-navigation></account-navigation>
                        <ad></ad>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="panel panel-default">
                        <div class="content">
                            <div class="package-container package-header">
                                <ul class="list-inline">
                                    <li class="id">ID</li>
                                    <li class="title">Order</li>
                                    <li class="expecting-date">Expecting on</li>
                                    <li class="status">Order status</li>
                                </ul>
                            </div>
                            <package-li v-bind:orderedPackage="package"></package-li>
                            <div class="row description-wrapper">
                                <div class="col-sm-7">
                                    <div>Client</div>
                                    <div class="author-wrapper">
                                        <div class="author">
                                            <div class="left-col">
                                                <router-link v-bind:to="`/users/${ package.buyer.id }`" class="btn-block photo-card-live myprofile">
                                                    <img class="border-image-profile img-circle photo-card"
                                                        alt="Image"
                                                        v-bind:src="package.buyer.avatar_path">
                                                </router-link>
                                            </div>
                                            <div class="right-col">
                                                <div class="name">
                                                    <router-link v-bind:to="`/users/${ package.buyer.id }`">{{package.buyer.username}}</router-link>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div>Order #{{package.id}}</div>
                                    <div>
                                        <router-link v-bind:to="`/service/detail/${package.package.service.id}`">{{package.package.service.title}}</router-link>
                                    </div>
                                    <div class="price">{{package.package.price}}&euro;</div>
                                    <div class="package-name">{{package.package.name}}</div>
                                    <div class="description">{{package.package.description}}</div>
                                </div>
                                <div class="col-sm-5 supplier-info-wrapper">
                                    <div>Supplier</div>
                                    <div v-if="isLate(package)">
                                        <span class="ns-icon">
                                            <img src="/vendor/img/late_alert.png" alt="">
                                        </span>
                                        <span>An issue with your order ? contact <router-link v-bind:to="`/customer-support/${package.id}/package`" class="underline-link">customer support</router-link></span>
                                     </div>
                                    <div class="supplier-wrapper">
                                        <div class="author">
                                            <div class="contact-btn-wrapper">
                                                <router-link class="ns-btn ns-btn-yel contact-btn" v-bind:to="`/user/ordered-contact/${ package.id }`">CONTACT</router-link>
                                            </div>
                                            <div class="left-col">
                                                <router-link v-bind:to="`/users/${ package.package.author_id }`" class="btn-block photo-card-live myprofile">
                                                    <img class="border-image-profile img-circle photo-card"
                                                        alt="Image"
                                                        v-bind:src="package.buyer.avatar_path">
                                                </router-link>
                                            </div>
                                            <div class="right-col">
                                                <div class="name">
                                                    <router-link v-bind:to="`/users/${ package.package.author_id }`">{{package.package.service.author.username}}</router-link>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="deliver-wrapper">
                                        <span>
                                            <i class="fa fa-clock-o" aria-hidden="true"></i>
                                        </span>
                                        <span>Delivery: {{package.package.days_to_deliver + (package.package.days_to_deliver > 1 ? ' days' : ' day')}} ({{ getDeliveryDate() | moment("DD MMM YYYY") }}) - order made on {{package.paying_date | moment("DD MMM YYYY")}}</span>
                                    </div>
                                    <div class="revision-wrapper">
                                        <span class="fa fa-refresh"></span>
                                        <span>Revisions: {{package.package.number_devisions}}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="instruction-wrapper">
                                <h5>Instructions</h5>
                                <ul class="list">
                                    <li>Please provide me X,Y,Z...</li>
                                    <li>And also you prefered colors, etc</li>
                                </ul>
                                <div class="form-group">
                                    <div class="">
                                        <textarea v-model="package.package.instruction"
                                                class="form-control input-sm"
                                                style="height: 100px;resize: none;"
                                                readonly
                                        ></textarea>
                                    </div>
                                </div>
                                <div v-if="package.documents.length > 0">Attachment(s)</div>
                                <div  class="form-group mb-0 row">
                                    <div class="col-sm-11">
                                        <a target="_blank"
                                            v-for="document in package.documents"
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
                            <div class="delivery-wrapper" v-if="package.package_delivery">
                                <div>Deliveries</div>
                                <br/>
                                <div>#1 Delivered by {{package.buyer.username}} on {{package.package_delivery.created_at |  moment("DD MMM YYYY")}}</div>
                                <div class="form-group">
                                    <div class="">
                                        <textarea v-model="package.package_delivery.description"
                                                class="form-control input-sm"
                                                style="height: 100px;resize: none;"
                                                readonly
                                        ></textarea>
                                    </div>
                                </div>
                                <div v-if="package.package_delivery.documents.length > 0">Attachment(s)</div>
                                <div  class="form-group mb-0 row">
                                    <div class="col-sm-11">
                                        <a target="_blank"
                                            v-for="document in package.package_delivery.documents"
                                            v-bind:href="document.url"
                                            class="btn-default btn-xs btn-border btn-block pull-left text-left fileContainer"
                                            style="display: block; padding: 10px;"
                                            >
                                            <i style="font-size: 130%; margin-right: 5px;" class="fa fa-file" aria-hidden="true"></i>
                                            <span class="myicon-right file-name-file">{{ document.filename }}</span>
                                        </a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div v-if="package.status==='waiting'">
                                                <a href="javascript:void(0)" class="ns-btn ns-btn-yel" style="color: white;" v-on:click="approveDelivery()">APPROVE A DELIVERY</a>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div v-if="package.status==='waiting' && package.asked_revisions < package.package.number_devisions">
                                                <a href="javascript:void(0)" class="ns-btn ns-btn-yel" v-on:click="openAskRevisionModal()" style="background-color: #f4a75a; color: white;">ASK FOR A REVISION</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div v-for="revision in package.package_revisions">
                                        <div>Revision asked by {{package.package.service.author.username}} on {{revision.created_at |  moment("DD MMM YYYY")}}</div>
                                        <div>
                                            <span><i aria-hidden="true" class="fa fa-clock-o"></i></span>
                                            <span>Please deliver before {{getDeliveryDate() | moment("DD MMM YYYY")}}</span>
                                        </div>
                                        <div class="form-group">
                                        <div class="">
                                            <textarea v-model="revision.description"
                                                    class="form-control input-sm"
                                                    style="height: 100px;resize: none;"
                                                    readonly
                                            ></textarea>
                                            </div>
                                        </div>
                                        <div  class="form-group mb-0 row">
                                            <div class="col-sm-11">
                                                <a target="_blank"
                                                    v-for="document in revision.documents"
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
                                    <div v-if="package.status === 'approved'">
                                        <span style="color: green;"><i class="fa fa-check" aria-hidden="true"></i></span>
                                        <span>Delivery approved on {{package.updated_at | moment("DD MMM YYYY")}}</span>
                                    </div>
                                    <div v-if="package.supplier_inv_id && package.status === 'approved'">
                                        <a href="javascript:void(0);" v-on:click="openPrintModal()" class="green-text">INVOICE {{package.supplier_inv_id}}</a>
                                    </div>
                                </div>
                            </div>
                            <li v-if="loading" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></li>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import accountNavigation from '../../components/account-navigation.vue';
    import ad from '../../components/ad.vue';
    import userOverview from '../../components/user-overview.vue';

    import packageLi from '../../components/package/ordered-li.vue';
    import starRating from 'vue-star-rating';

    export default {
        data() {
            return {
                package: null,
                loading: false,
                submitting: false,
                feedback: {
                    message: '',
                    communication: 0,
                    skill: 0,
                    deadline: 0,
                    experience: 0
                },
                errors: {},
                revision: {
                    description: '',
                    attachments: []
                }
            }
        },
        created() {
            setTimeout(() => {
                this.getOrderedPackageById(this.$route.params.id);
            }, 0);
        },
        computed: {
            auth() {
                return this.$store.getters.user
            },
            user() {
                return this.$store.getters.user;
            }
        },
        components: {
            'ad': ad,
            'account-navigation': accountNavigation,
            'user-overview': userOverview,
            'package-li': packageLi,
            'star-rating': starRating
        },
        methods: {
            getOrderedPackageById(id) {
                this.loading = true;

                this.$http.get(`/api/services/ordered-package/${id}`).then(response => {
                    this.package = response.data;
                }, error => {
                    console.log(error);
                }).finally(() => {
                    this.loading = false;
                });
            },
            getDeliveryDate() {
                let d_date = new Date(this.package.paying_date);
                d_date.setDate(d_date.getDate() + parseInt(this.package.package.days_to_deliver));
                return d_date;
            },
            approveDelivery() {
                this.loading = true;
                this.errors = {};
                this.submitting = true;
                this.$http.post(`/api/services/package/delivery/approve`, {
                    package_order_id: this.package.id
                }).then(response => {
                    this.package = response.data;
                    $('#feedbackModal').modal('show');
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
                this.feedback.seller_id = this.package.seller_id;
                this.feedback.buyer_id = this.package.buyer_id;
                this.feedback.package_id = this.package.package.id;
                this.feedback.ordered_package_id = this.package.id;
                this.feedback.service_id = this.package.package.service_id;
                var totalRating = parseInt(this.feedback.communication) + parseInt(this.feedback.skill) + parseInt(this.feedback.deadline) + parseInt(this.feedback.experience);
                this.feedback.rating = Math.round(totalRating / 4);
                
                this.$http.post(`/api/services/package/feedback`, this.feedback).then(() => {
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
            openAskRevisionModal(index) {
                this.loading = false;
                this.submitting = false;
                $('#askingRevisionModal').modal('show');
            },
            sendAskRevision() {
                this.submitting = true;
                this.errors = {};
                this.revision.ordered_package_id = this.package.id;

                this.$http.post(`/api/services/package/revision`, this.revision).then(response => {
                    this.package.status = response.body.status;
                    this.revision = {
                        description: '',
                        attachments: []
                    };

                    $('#askingRevisionModal').modal('hide');
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

                this.$http.post('/api/services/package/document/revision', data).then(response => {
                    this.revision.attachments[index].filename = response.body.filename;
                }, response => {
                    alert(response.body.attachment.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
                })
            },
            openPrintModal(index) {
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
            getPriceWithFee(price) {
                var pr = parseFloat(price.toFixed(2));
                var f = parseFloat((price * 3.5 / 100).toFixed(2));
                return (pr + f).toFixed(2);
            },
            isLate(oPackage) {
                if (this.isDelivered(oPackage)) {
                    return false;
                }
                
                let now = new Date();
                return now > this.getDeliveryDate(oPackage);
            },
            isDelivered(oPackage) {
                return oPackage.status !== 'new';
            }
        }
    }
</script>
<style>
.ordered-package-detail .description-wrapper {
    padding: 0 10px;
}

.ordered-package-detail .author-wrapper {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    align-items: center;
}

.ordered-package-detail .supplier-wrapper {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    justify-content: flex-end;
}

.ordered-package-detail .author {
    display: -webkit-flex;
    display: flex;
    -webkit-flex-flow: row nowrap;
    flex-flow: row nowrap;
    margin: 10px 0;
}
.ordered-package-detail .author .left-col {
    width: 40px;
}

.ordered-package-detail .author .left-col img {
    display: inline-block;
    border-radius: 50%;
    height: 40px;
    width: 40px;
}

.ordered-package-detail .author .right-col {
    display: flex;
    display: -webkit-flex;
    align-items: center;
}

.ordered-package-detail .contact-btn-wrapper {
    width: 100px;
    margin: auto;
}

.ordered-package-detail .contact-btn {
    margin-bottom: 0px !important;
    padding: 4px;
}

.ordered-package-detail .price {
    color: #26cc68;
    font-size: 18px;
}

.ordered-package-detail .package-name {
    text-transform: uppercase;
    font-size: 18px;
}

.ordered-package-detail .description {

}

.ordered-package-detail .supplier-info-wrapper {
    text-align: right;
}

.ordered-package-detail .deliver-wrapper {
    text-align: left;
}

.ordered-package-detail .revision-wrapper {
    text-align: left;
}

.ordered-package-detail .instruction-wrapper {
    margin: 10px;
    border-top: 1px solid #c3c3c3;
    border-bottom: 1px solid #c3c3c3;
}
.ordered-package-detail .instruction-header {
    text-align: center;
}
.ordered-package-detail .instruction-wrapper .title {
    text-align: center;
}
.ordered-package-detail .instruction-wrapper .list {
    padding-left: 40px;
}
.ordered-package-detail .instruction-wrapper .list li {
    list-style-type: disc !important;
}

.ordered-package-detail .delivery-wrapper {
    margin: 10px;
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

.underline-link {
    text-decoration: underline;
}


@media (min-width: 768px) {
    #printModal .modal-dialog {
        width: 80%;
    }
}
</style>