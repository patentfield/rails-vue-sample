import { mount } from '@vue/test-utils';
import 'init/application';
import Component from 'components/component.vue';

describe('Sample', () => {
  const wrapper = mount(Component)

  it('is a Vue instance', () => {
    expect(wrapper.vm).toBeTruthy()
  })
  it('renders the correct markup', () => {
    expect(wrapper.html()).toContain('<p>sample component</p>')
  })

})
