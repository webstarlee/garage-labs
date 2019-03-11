<template>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default margin-zero panel-user">
                    <div class="panel-body padding-bottom-zero padding-top-zero">
                        <ul class="list-grid">
                            <span class="link"
                                  v-on:click="toggleForm()"
                                  data-toggle="modal"
                                  data-target="#reference-modal"
                            >
                                <i class="fa fa-plus-circle" aria-hidden="true"></i> Add a reference
                            </span>
                        </ul>
                        <div class="modal fade" id="reference-modal" tabindex="-1" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">{{ isRecordNew ? 'Ajouter une référence' : 'Update reference' }}</h4>
                                    </div>
                                    <div class="modal-body">
                                        <form v-on:submit.prevent="send()">
                                            <fieldset v-bind:disabled="loading">
                                                <div class="form-group form-group-sm" v-bind:class="{ 'has-error': errors.title !== undefined }">
                                                    <label>Title <span class="text-danger">*</span></label>
                                                    <input v-model="reference.title" class="form-control input-sm" />
                                                    <p v-if="errors.title !== undefined" class="help-block">{{ errors.title.join() }}</p>
                                                </div>
                                                <div class="form-group form-group-sm" v-bind:class="{ 'has-error': errors.description !== undefined }">
                                                    <label>Description <span class="text-danger">*</span></label>
                                                    <textarea v-model="reference.description" class="form-control input-sm"></textarea>
                                                    <p v-if="errors.description !== undefined" class="help-block">{{ errors.description.join() }}</p>
                                                </div>
                                                <div class="form-group form-group-sm" v-bind:class="{ 'has-error': errors.url !== undefined }">
                                                    <label>URL</label>
                                                    <input v-model="reference.url" class="form-control input-sm" />
                                                    <p v-if="errors.url !== undefined" class="help-block">{{ errors.url.join() }}</p>
                                                </div>
                                                <div class="form-group form-group-sm" v-bind:class="{ 'has-error': errors.image !== undefined }">
                                                    <label>Main image <span v-show="isRecordNew" class="text-danger">*</span></label>
                                                    <input type="file" id="referenceFile" class="form-control input-sm" />
                                                    <p v-if="errors.image !== undefined" class="help-block">{{ errors.image.join() }}</p>
                                                </div>
                                                <documents-upload v-bind:documents="reference.documents"
                                                                  v-on:addEmptyDocument="addEmptyDocument"
                                                                  v-bind:error="errors.documents"
                                                ></documents-upload>
                                                <button type="submit" class="btn btn-block btn-sm btn-primary">Create</button>
                                            </fieldset>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import DocumentsUpload from '../components/documents-upload.vue';

    export default {
        data() {
            return {
                index: null,
                reference: {
                    documents: []
                },
                formOpen: false,
                loading: false,
                errors: {}
            }
        },
        created() {
            this.$events.on('EditReference', (reference, index) => {
                this.index = index;
                this.errors = {};
                this.reference = reference;
                this.formOpen = true;
            });
        },
        computed: {
            auth() {
                return this.$store.getters.user;
            },
            isRecordNew() {
                return this.reference === undefined || this.reference.id === undefined;
            }
        },
        components: {
            'documents-upload': DocumentsUpload
        },
        methods: {
            addEmptyDocument() {
                this.reference.documents.push({});
            },
            toggleForm() {
                this.formOpen = ! this.formOpen;
                if(this.formOpen === false) {
                    this.reference = {
                        documents: []
                    };
                    this.errors = {};
                }
            },
            send() {
                this.errors = {};
                let url = null;
                let data = this.generateFormData();

                if(this.isRecordNew) {
                    url = `/api/references`;
                } else {
                    url = `/api/references/${ this.reference.id }/update`;
                }

                this.$http.post(url, data).then(response => {
                    this.formOpen = false;
                    this.closeModal();

                    if(this.isRecordNew) {
                        this.$events.emit('ReferenceCreated', response.data);
                    } else {
                        this.$events.emit('ReferenceUpdated', response.data);
                    }
                }, response => {
                    this.errors = response.data;
                }).finally(() => {
                    this.loading = false;
                });
            },
            closeModal() {
                document.querySelector('#reference-modal').className = 'modal fade';
                document.querySelector('#reference-modal').setAttribute('style', 'display: none;');
                document.querySelector('.modal-backdrop.fade.in').parentNode.removeChild(document.querySelector('.modal-backdrop.fade.in'));
            },
            generateFormData() {
                let data = new FormData;

                if(this.reference.title) {
                    data.append('title', this.reference.title);
                }

                if(this.reference.description) {
                    data.append('description', this.reference.description);
                }

                if(this.reference.url) {
                    data.append('url', this.reference.url);
                }

                if(this.reference.documents) {
                    for(let i = 0; i < this.reference.documents.length; ++i) {
                        if(this.reference.documents[i].id !== undefined) {
                            data.append('documents[][id]', this.reference.documents[i].id);
                        }
                    }
                }

                if(document.getElementById('referenceFile').files[0]) {
                    data.append('image', document.getElementById('referenceFile').files[0]);
                }

                return data;
            }
        }
    }
</script>

<style scoped>
    .btn-delete {
        padding: 5px 9px;
    }
</style>