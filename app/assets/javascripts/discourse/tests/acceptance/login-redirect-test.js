import { currentRouteName, visit } from "@ember/test-helpers";
import { test } from "qunit";
import { acceptance } from "discourse/tests/helpers/qunit-helpers";

acceptance("Login redirect - anonymous", function (needs) {
  needs.pretender((server, helper) => {
    server.get(`/session/passkey/challenge.json`, () =>
      helper.response({ challenge: "smth" })
    );
  });

  test("redirects login to default homepage", async function (assert) {
    await visit("/login");
    assert.strictEqual(
      currentRouteName(),
      "discovery.latest",
      "it works when latest is the homepage"
    );
  });
});

acceptance("Login redirect - categories default", function (needs) {
  needs.settings({
    top_menu: "categories|latest|top|hot",
  });

  needs.pretender((server, helper) => {
    server.get(`/session/passkey/challenge.json`, () =>
      helper.response({ challenge: "smth" })
    );
  });

  test("when site setting is categories", async function (assert) {
    await visit("/login");
    assert.strictEqual(
      currentRouteName(),
      "discovery.categories",
      "it works when categories is the homepage"
    );
  });
});
