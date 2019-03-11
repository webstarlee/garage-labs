<template>
    <div id="app">
        <my-header style="background-color:#1d1d1d;"></my-header>
        <router-view></router-view>
        <my-footer></my-footer>
    </div>
</template>

<script>
    import header from './components/header.vue';
    import footer from './components/footer.vue';

    export default {
        components: {
            'my-header': header,
            'my-footer': footer
        }
    }

</script>

