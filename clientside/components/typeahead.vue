<template>
    <div style="position: relative;">
        <i class="fa fa-spinner fa-spin" v-show="loading"></i>

        <input type="text"
               placeholder="Start typing"
               class="form-control input-sm typeahead"
               autocomplete="off"
               v-model="query"
               @keydown.down="down"
               @keydown.up="up"
               @keydown.enter="hit"
               @keydown.esc="reset"
               @blur="reset"
               @input="update"
        />

        <!-- the list -->
        <ul>
            <li v-for="(item, $index) in items" :class="activeClass($index)" @mousedown="hit" @mousemove="setActive($index)">
                <span v-text="item.name"></span>
            </li>
        </ul>
    </div>
</template>

<script>
    import VueTypeahead from 'vue-typeahead'

    export default {
        extends: VueTypeahead,
        data () {
            return {
                minChars: 3,
                selectFirst: true
            }
        },
        methods: {
            hit() {
                if (this.current !== -1) {
                    this.onHit(this.items[this.current])
                    this.clear();
                } else {
                    if(this.query.length > 0) {
                        this.loading = true;
                        this.$http.post(this.createUrl, { name: this.query }).then(response => {
                            this.onHit(response.data);
                        }, response => {
                            throw { code: response.status, error: response.body };
                        }).then(() => {
                            this.loading = false;
                            this.clear();
                        });
                    }
                }
            },
            onHit(item) {
                this.$emit('selected', item);
                this.items = [];
            },
            clear() {
                this.query = '';
            },
            fetch () {
                if (!this.$http) {
                    return util.warn('You need to install the `vue-resource` plugin', this)
                }

                if (!this.src) {
                    return util.warn('You need to set the `src` property', this)
                }

                const src = this.queryParam
                        ? this.src
                        : this.src + this.query

                const params = this.queryParam
                        ? Object.assign({ [this.queryParam]: this.query }, this.data)
                        : this.data

                return this.$http.get(src, { params })
            },
            prepareResponseData (data) {
                return data
            },
            reset () {
                this.items = []
                this.loading = false
            }
        },
        watch: {
            loading(val) {
                this.$emit(val === true ? 'loading' : 'loaded');
            }
        },
        props: ['src', 'createUrl', 'queryParam']
    }
</script>

<style scoped>
    i {
        position: absolute;
        left: 0;
        opacity: 0.4;
    }
    ul {
        position: absolute;
        padding: 0;
        margin-top: 8px;
        min-width: 100%;
        background-color: #fff;
        list-style: none;
        border-radius: 4px;
        box-shadow: 0 0 10px rgba(0,0,0, 0.25);
        z-index: 1000;
    }
    li {
        padding: 10px 16px;
        border-bottom: 1px solid #ccc;
        cursor: pointer;
    }
    li:first-child {
        border-top-left-radius: 4px;
        border-top-right-radius: 4px;
    }
    li:last-child {
        border-bottom-left-radius: 4px;
        border-bottom-right-radius: 4px;
        border-bottom: 0;
    }
    span {
        display: block;
        color: #2c3e50;
    }
    .active {
        background-color: #34495e;
    }
    .active span {
        color: white;
    }
</style>