<template>
    <div class="form-group form-group-sm" v-bind:class="{ 'has-error': error !== undefined }">
        <fieldset v-bind:disabled="uploading">
            <label>Documents <i v-show="uploading" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i></label>
            <div class="col-md-12 row add-btn">
                <span v-on:click="addNewDocument()" class="link">+ Add a document (jpeg, png, doc(x), ppt(x), pdf, xls, csv, txt)</span>
            </div>
            <div v-for="(document, index) in documents" class="row document">
                <template v-if="document.id !== undefined">
                    <div class="col-md-10">
                        <a target="_blank"
                           v-bind:href="document.url"
                           class="btn-default btn-xs btn-border btn-block pull-left text-left fileContainer"
                        >
                            <i style="font-size: 130%; margin-right: 5px;" class="fa fa-file" aria-hidden="true"></i>
                            <span class="myicon-right file-name-file">{{ document.filename }}</span>
                        </a>
                    </div>
                    <div class="col-md-2">
                        <button type="button" v-on:click="deleteDocument(index)" class="btn btn-inverse btn-delete btn-sm">X</button>
                    </div>
                </template>
                <template v-else>
                    <div class="col-md-10">
                        <input type="file" v-on:change="upload($event, index)" class="form-control input-sm" />
                    </div>
                    <div class="col-md-2">
                        <button type="button" v-on:click="deleteDocument(index)" class="btn btn-inverse btn-sm">X</button>
                    </div>
                </template>
            </div>
            <p v-if="error !== undefined" class="help-block">{{ error.join() }}</p>
        </fieldset>
    </div>
</template>

<script type="text/babel">
    export default {
        data() {
            return {
                uploading: false
            }
        },
        props: [
            'error',
            'documents'
        ],
        methods: {
            addNewDocument() {
                this.$emit('addEmptyDocument');
            },
            upload(event, index) {
                this.uploading = true;

                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('attachment', file);

                this.$http.post('/api/documents', data).then(response => {
                    this.documents[index] = response.data;
                }, response => {
                    alert(response.body.attachment.join());
                    event.target.value = '';
                }).finally(() => {
                    this.uploading = false;
                });
            },
            deleteDocument(index) {
                this.documents.splice(index, 1);
            }
        }
    }
</script>

<style scoped>
    .add-btn {
        margin-bottom: 10px;
    }

    .fileContainer {
        padding: 8px;
    }

    .row.document {
        margin-bottom: 10px;
    }
</style>