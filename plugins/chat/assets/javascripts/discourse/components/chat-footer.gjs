import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import DButton from "discourse/components/d-button";
import concatClass from "discourse/helpers/concat-class";
import i18n from "discourse-common/helpers/i18n";
import eq from "truth-helpers/helpers/eq";

export default class ChatFooter extends Component {
  @service router;
  @service chat;
  @service siteSettings;

  threadsEnabled = this.siteSettings.chat_threads_enabled;

  get directMessagesEnabled() {
    return this.chat.userCanAccessDirectMessages;
  }

  get shouldRenderFooter() {
    return this.threadsEnabled || this.directMessagesEnabled;
  }

  <template>
    {{#if this.shouldRenderFooter}}
      <nav class="c-footer" {{this.updateThreadCount}}>
        <DButton
          @route="chat.channels"
          @icon="comments"
          @translatedLabel={{i18n "chat.channel_list.title"}}
          aria-label={{i18n "chat.channel_list.aria_label"}}
          id="c-footer-channels"
          class={{concatClass
            "btn-flat"
            "c-footer__item"
            (if (eq this.router.currentRouteName "chat.channels") "--active")
          }}
        />

        {{#if this.directMessagesEnabled}}
          <DButton
            @route="chat.direct-messages"
            @icon="users"
            @translatedLabel={{i18n "chat.direct_messages.title"}}
            aria-label={{i18n "chat.direct_messages.aria_label"}}
            id="c-footer-direct-messages"
            class={{concatClass
              "btn-flat"
              "c-footer__item"
              (if
                (eq this.router.currentRouteName "chat.direct-messages")
                "--active"
              )
            }}
          />
        {{/if}}

        {{#if this.threadsEnabled}}
          <DButton
            @route="chat.threads"
            @icon="discourse-threads"
            @translatedLabel={{i18n "chat.my_threads.title"}}
            aria-label={{i18n "chat.my_threads.aria_label"}}
            id="c-footer-threads"
            class={{concatClass
              "btn-flat"
              "c-footer__item"
              (if (eq this.router.currentRouteName "chat.threads") "--active")
            }}
          />
        {{/if}}
      </nav>
    {{/if}}
  </template>
}
