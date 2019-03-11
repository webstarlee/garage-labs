<template>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <add-reference-form v-if="auth && user && auth.id === user.id"></add-reference-form>
            <div class="col-md-12">
                <div class="row">
                    <reference-modal v-bind:reference="reference"></reference-modal>
                    <div v-if="references.length > 0" v-for="(reference, index) in references" class="col-sm-6 col-md-3 col-thumb">
                        <div class="thumbnail  padding-top-zero ">
                            <span data-toggle="modal"
                                  data-target="#reference-show-modal"
                                  v-on:click="showReference(reference)"
                                  class="position-relative btn-block link"
                            >
                                <img v-bind:src="reference.image_url" class="image-url img-responsive btn-block">
                            </span>
                            <div class="caption">
                                <h1 class="title-shots">{{ reference.title }}</h1>
                                <small>{{ reference.description.length > 20 ? `${ reference.description.substr(0, 20) }...` : reference.description }}</small>
                            </div>
                            <div v-if="auth && user && auth.id === user.id" class="caption">
                                <p class="actions">
                                    <span class="pull-right" style="margin-top:-5px">
                                        <span class="myicon-right strongSpan">{{ reference.updated_at | moment("from") }}</span>
                                        <span class="link"
                                              data-toggle="modal"
                                              data-target="#reference-modal"
                                              v-on:click="fireEditReferenceEvent(reference, index)"
                                        >
                                            <small class="myicon-right file-name"></small> <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                        </span>
                                        <a href="javascript:void(0)" v-on:click="deleteReference(reference, index)">
                                            <small class="myicon-right file-name"></small> <i class="fa fa-times" aria-hidden="true"></i>
                                        </a>
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div v-if="references.length === 0" style="padding: 50px 0 100px;">
                        <h1>Aucune évaluation.</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script type="text/babel">
    import AddReferenceForm from '../../components/add-reference-form.vue';
    import ReferenceModal from '../../components/reference-modal.vue';

    export default {
        data() {
            return {
                references: [],
                reference: {},
                fetching: true
            }
        },
        created() {
            this.fetchReferences();

            this.$events.on('ReferenceCreated', this.pushReference);
            this.$events.on('ReferenceUpdated', this.updateReference);
        },
        computed: {
            auth() {
                return this.$store.getters.user;
            }
        },
        components: {
            'add-reference-form': AddReferenceForm,
            'reference-modal': ReferenceModal
        },
        props: [
            'user',
            'found',
            'loading'
        ],
        methods: {
            showReference(reference) {
                this.reference = reference;
            },
            pushReference(reference) {
                this.references.unshift(reference);
            },
            updateReference(reference, index) {
                this.references[index] = reference;
            },
            fireEditReferenceEvent(reference, index) {
                this.$events.emit('EditReference', reference, index);
            },
            fetchReferences() {
                this.fetching = true;

                this.$http.get(`/api/users/${ this.$route.params.id }/references`).then(response => {
                    this.references = response.data;
                }, response => {
                    console.log(response);
                }).finally(() => {
                    this.fetching = false;
                })
            },
            deleteReference(reference, index) {
                this.$http.post(`/api/references/${ reference.id }/delete`).then(response => {
                    this.references.splice(index, 1);
                }, response => {
                    console.log(response);
                });
            }
        }
    }
</script>