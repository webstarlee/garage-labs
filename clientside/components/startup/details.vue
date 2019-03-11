<template>
    <div class="panel panel-default">
        <div class="text-center" v-if="loading" style="padding: 100px 0;">
            <i class="fa fa-spinner fa-spin fa-3x fa-fw"></i>
        </div>
        <ol v-if="! loading" class="details-shot">
            <li class="li-title"><strong>Détails</strong></li>
            <li>
                <span class="icon-clock myicon-right color-strong"></span>
                Published
                <span class="timeAgo pull-right color-strong">{{ data.created_at | moment('from') }}</span>
            </li>
            <li>
                <span class="fa fa-eye myicon-right color-strong"></span>
                Views
                <strong class="pull-right color-strong">{{ data.views }}</strong>
            </li>
            <li>
                <span class="fa fa-comment myicon-right color-strong"></span>
                Contacts
                <strong class="pull-right color-strong">{{ data.num_contacts }}</strong>
            </li>
            <li>
                <span class="fa fa-share-alt myicon-right color-strong"></span> Partager
                <ul class="list-inline pull-right">
                    <li><a title="Facebook" v-bind:href="`https://www.facebook.com/sharer/sharer.php?u=${ location }`" target="_blank"><img src="/vendor/img/social/facebook.png" width="20" class="img-circle"></a></li>
                    <li><a title="Twitter" v-bind:href="`https://twitter.com/intent/tweet?url=${ location }`" data-url="http://shotpro.miguelvasquez.net/shots/343-website-example-test" target="_blank"><img width="20" src="/vendor/img/social/twitter.png" class="img-circle"></a></li>
                    <li><a title="Google Plus" v-bind:href="`https://plus.google.com/share?url=${ location }`" target="_blank"><img width="20" class="img-circle" src="/vendor/img/social/googleplus.png"></a></li>
                    <li style="padding-right: 0;"><a title="Pinterest" v-bind:href="`http://www.pinterest.com/pin/create/button/?url=${ location }`" target="_blank"><img width="20" src="/vendor/img/social/pinterest.png" class="img-circle"></a></li>
                </ul>
            </li>
            <hr class="margin-top-zero">
        </ol>
        </div>
</template>

<script>
    export default {
        computed: {
            location: function() {
                return window.location.href;
            }
        },
        props: ['loading', 'data']
    }
</script>