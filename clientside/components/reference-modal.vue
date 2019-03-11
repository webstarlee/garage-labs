<template>
    <div class="modal fade" id="reference-show-modal" tabindex="-1" role="dialog">
        <div class="modal-dialog wide" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">{{ reference.title }}</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <img class="main" v-bind:src="reference.image_url" />
                        </div>
                        <div class="col-md-6">
                            <h3>{{ reference.title }}</h3>
                            <p v-if="reference.url">
                                <a class="btn btn-primary btn-sm" v-bind:href="reference.url" target="_blank">Visit website</a>
                            </p>
                            <p>
                                {{ reference.description }}
                            </p>
                            <label>Documents </label>
                            <div v-for="document in reference.documents" class="row">
                                <div class="col-md-10">
                                    <a target="_blank"
                                       v-bind:href="document.url"
                                       class="btn-default btn-xs btn-border btn-block pull-left text-left fileContainer"
                                    >
                                        <i style="font-size: 130%; margin-right: 5px;" class="fa fa-file" aria-hidden="true"></i>
                                        <span class="myicon-right file-name-file">{{ document.filename }}</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    export default {
        props: ['reference']
    }
</script>

<style scoped>
    img.main {
        max-height: 500px;
        max-width: 100%;
    }
</style>