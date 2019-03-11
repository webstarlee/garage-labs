<template>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <div class="col-md-4">
                <div class="responsive-side collapse">
                    <user-overview v-bind:data="user"></user-overview>
                    <account-navigation></account-navigation>
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading grid-panel-title">
                        <span class="btn-block">Avatar and Cover <i v-show="loading" class="fa fa-spinner fa-spin fa-3x fa-fw inline"></i></span>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal">
                            <fieldset v-bind:disabled="loading">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label input-sm">Avatar 2MB - 128x128px</label>
                                    <div class="col-sm-10">
                                        <img style="margin-bottom: 10px; max-height: 100px; max-width: 100px;" v-bind:src="user.avatar_path">
                                        <input @change="uploadAvatar($event)" type="file" accept="image/*" />
                                    </div>
                                </div>
                            </fieldset>
                        </form>
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label input-sm">Cover 2MB - 1500px</label>
                                <div class="col-sm-10">
                                    <div class="label_cover"
                                         v-bind:style="`-webkit-border-radius: 5px;
                                                border-radius: 5px;
                                                margin-bottom: 10px;
                                                width: 100%;
                                                height: 200px;
                                                background-color: #D1D1D1;
                                                background-position: center center;
                                                background-size: cover;
                                                background-image: url(${ user.cover_path } );`"
                                    ></div>
                                    <input @change="uploadCover($event)" type="file" accept="image/*">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import accountNavigation from '../components/account-navigation.vue';
    import userOverview from '../components/user-overview.vue';

    export default {
        data() {
            return {
                user: {},
                loading: false
            }
        },
        created() {
            this.user = this.$store.getters.user;
        },
        components: {
            'account-navigation': accountNavigation,
            'user-overview': userOverview
        },
        methods: {
            uploadAvatar(event) {
                this.loading = true;

                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('file', file);
                this.loading = true;

                this.$http.post('/api/account/update-avatar', data).then(response => {
                    this.$store.commit('setUserAvatarPath', response.data.avatar_path);
                }, response => {
                    alert(response.body.file.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
                });
            },
            uploadCover(event) {
                this.loading = true;

                let file = event.target.files[0] || event.dataTransfer.files[0];
                let data = new FormData;

                data.append('file', file);
                this.loading = true;

                this.$http.post('/api/account/update-cover', data).then(response => {
                    this.$store.commit('setUserCoverPath', response.data.cover_path);
            }, response => {
                    alert(response.body.file.join());
                    event.target.value = '';
                }).finally(() => {
                    this.loading = false;
            });
            }
        }
    }
</script>