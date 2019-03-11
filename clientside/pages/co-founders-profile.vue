<template>
    <div class="container wrap-ui content-wrapper">
        <div class="row">
            <div class="col-md-4">
                <div class="responsive-side collapse">
                     <user-overview v-bind:data="user"></user-overview> 
                </div>
            </div>
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading grid-panel-title">
                        <span class="btn-block">Mettre à jour mon profil</span>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal form-account" role="form"  v-if="user">
                            <fieldset v-bind:disabled="loading">
                                <div class="form-group">
                                    <label for="firstname" class="col-sm-2 control-label input-sm">First name</label>
                                    <div class="col-sm-10">
                                        <input type="text" disabled="disabled" v-model="user.first_name" class="form-control input-sm" id="firstname" />
                                       </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" >
                                    <label for="last_name" class="col-sm-2 control-label input-sm">Last name</label>
                                    <div class="col-sm-10">
                                        <input type="text" disabled="disabled" id="last_name" v-model="user.last_name" class="form-control input-sm" placeholder="Nom de famille" />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group">
                                    <label for="username" class="col-sm-2 control-label input-sm">Username
                                    </label>
                                    <div class="col-sm-10">
                                        <input id="username" disabled="disabled" v-model="user.username" class="form-control input-sm" placeholder="Pseudonyme" />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group">
                                    <label for="email" class="col-sm-2 control-label input-sm">Email</label>
                                    <div class="col-sm-10">
                                        <input disabled="disabled" v-model="user.email" class="form-control input-sm" id="email" placeholder="Email" />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" >
                                    <label for="company_name" class="col-sm-2 control-label input-sm">Société</label>
                                    <div class="col-sm-10">
                                        <input disabled="disabled" v-model="user.company_name" class="form-control input-sm" id="company_name" placeholder="Nom de la société" />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group">
                                    <label for="company_phone" class="col-sm-2 control-label input-sm">Incorporation number</label>
                                    <div class="col-sm-10">
                                        <input disabled="disabled" v-model="user.company_phone" class="form-control input-sm" id="company_phone" placeholder="Téléphone" />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group">
                                    <label for="address" class="col-sm-2 control-label input-sm">Address</label>
                                    <div class="col-sm-10">
                                        <input disabled="disabled" v-model="user.address" class="form-control input-sm" id="address" placeholder="Adresse" />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" >
                                    <label for="postal_code" class="col-sm-2 control-label input-sm">Code postal</label>
                                    <div class="col-sm-10">
                                        <input disabled="disabled" v-model="user.postal_code" class="form-control input-sm"  />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-if="user.countries">
                                    <label for="country_id" class="col-sm-2 control-label input-sm">Pays</label>
                                    <div class="col-sm-10">
                                       <input disabled="disabled" v-model="user.countries.name" class="form-control input-sm"   />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group" v-if="user.cities">
                                    <label for="city_id" class="col-sm-2 control-label input-sm">Ville</label>
                                    <div class="col-sm-10">
                                      <input disabled="disabled" v-model="user.cities.name" class="form-control input-sm"  placeholder="75008" />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                                <div class="form-group">
                                    <label for="website" class="col-sm-2 control-label input-sm">Site internet</label>
                                    <div class="col-sm-10">
                                        <input disabled="disabled" v-model="user.website" class="form-control input-sm" id="website" />
                                    </div>
                                </div>
                                <!-- **** form-group **** -->
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import userOverview from '../components/user-overview.vue';

    export default {
        created() {
            this.user = this.fetch();
        },
        data() {
            return {
                default_url: `/api/users/${ this.$route.params.id }`,
                user: null
            }
        },
        methods: {
          fetch() {
                this.loading = true;

                setTimeout(() => {
                    this.$http.get(this.default_url).then(response => {
                        this.user = response.body;
                    }).then(() => {
                        this.loading = false;
                    });
                }, 0);
            }
        },
        components: {
            'user-overview': userOverview
        }
    }
</script>