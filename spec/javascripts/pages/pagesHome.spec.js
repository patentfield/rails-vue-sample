import { mount } from '@vue/test-utils';
import 'init/application';
import pagesHome from 'pages/pagesHome.vue';

describe('pagesHome', () => {
  const wrapper = mount(pagesHome)

  it('is a Vue instance', () => {
    expect(wrapper.vm).toBeTruthy()
  })

})
