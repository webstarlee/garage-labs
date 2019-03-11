<template>
    <div class="row content-wrapper">
        <div class="col-md-10 col-md-offset-1">
            <h2 class="instruction-header">Order instructions</h2>
            <div class="panel panel-default instruction-container">
                <h4 class="title">Your order is confirmed!</h4>
                <div>
                Please fill-in the instructions for your order, that the supplier can starts working:
                </div>
                <h4>Instructions</h4>
                <div class="form-group">
                    <div class="">
                        <textarea v-model="package.instruction"
                                class="form-control input-sm"
                                style="height: 100px;resize: none;"
                                readonly
                        ></textarea>
                    </div>
                </div>
                <div class="form-group" v-bind:class="{ 'has-error': errors.instruction !== undefined && errors.instruction.length }">
                    <div class="">
                        <textarea v-model="instruction.instruction"
                                class="form-control input-sm"
                                style="height: 100px;resize: none;"
                                placeholder="My instructions"
                        ></textarea>
                        <p v-if="errors.instruction !== undefined" class="help-block">{{ errors.instruction.join() }}</p>
                    </div>
                </div>
                <div v-for="(attachment, index) in instruction.attachments" class="form-group mb-0">
                    <div class="row">
                        <div id="upload_inputs col-sm-12">
                            <div class="col-sm-6">
                                <input type="file" @change="uploadAttachment(attachment, $event, index)" class="up_0">
                                <p class="help-block"></p>
                            </div>
                            <div class="col-sm-6">
                                <a id="up_0"
                                @click="instruction.attachments.splice(index, 1)"
                                style="padding: 5px 10px;"
                                class="delete_up pull-right btn btn-inverse btn-sm"
                                value="remove"
                                >X</a>
                            </div>
                        </div>
                    </div>
                </div>
                 <div class="form-group row">
                    <div class="col-sm-12">
                        + <a href="javascript:void(0)" @click="instruction.attachments.push({})"><u>Add a file</u></a>
                    </div>
                </div>
                 <div class="form-group">
                    <button data-toggle="modal" class="ns-btn ns-btn-yel" style="width: 100%;" v-on:click="submitInstruction()">
                        SEND INSTRUCTIONS
                    </button>
                    <div v-if="submitting" style="padding: 20px 0px;" class="li-group-msg hoverList text-center"><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></div>
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
                instruction: {
                    attachments: []
                },
                errors: {},
                submitting: false,
                package: {}
            }
        },
        created() {
            this.getPackageById(this.$route.params.package_id);
        },
        methods: {
             uploadAttachment(attachment, event, index) {
                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('attachment', file);
                this.loading = true;

                this.$http.post('/api/services/package/document/upload', data).then(response => {
                    this.instruction.attachments[index].filename = response.body.filename;
                }, response => {
                    alert(response.body.attachment.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
                })
            },
            submitInstruction() {
                this.submitting = true;
                this.errors = {};
                this.instruction.package_order_id = this.$route.params.id;

                this.$http.post(`/api/services/package/instruction`, this.instruction).then(response => {
                    this.$router.push(`/order/thankyou/${response.body.package_id}/${response.body.ordered_package_id}`);
                }, response => {
                    this.errors = response.body;
                }).then(() => {
                    this.submitting = false;
                });
            },
            getPackageById(id) {
                this.$http.get(`/api/services/package/${id}`).then(response => {
                    this.package = response.data.package;
                },
                response => {
                    alert('You cannot make the order for your own package or you are not login yet.');
                    this.$router.push('/');
                }
                )
                .finally(() => {
                    this.loading = false;
                });
            }
        }
    }
</script>
<style>
.instruction-container {
    margin: 10px;
}
.instruction-header {
    text-align: center;
}
.instruction-container .title {
    text-align: center;
}
.instruction-container .list {
    padding-left: 40px;
}
.instruction-container .list li {
    list-style-type: disc !important;
}
</style>