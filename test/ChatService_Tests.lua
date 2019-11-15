package.path = "../src/?.lua;" .. package.path

function _G.GetAddOnMetadata(...)
    return "fakemeta"
end


require 'busted.runner'()
require 'MageVendor'
require 'ChatService'


describe("checkWantsPort", function()
    -- tests go here

    it("returns true if the message contains a phrase that wants a port", function()
        assert.is_true(checkWantsPort("wtb port"))
        assert.is_true(checkWantsPort("can I get a tb port"))
        assert.is_true(checkWantsPort("wtb hearth org"))
        assert.is_true(checkWantsPort("ORG port pls"))
        assert.is_true(checkWantsPort("can I get an org port"))
        assert.is_true(checkWantsPort("port uc plz"))
        assert.is_true(checkWantsPort("port to org please"))
        assert.is_true(checkWantsPort("buy portal UC"))
        assert.is_true(checkWantsPort("WTB ORG"))
        assert.is_true(checkWantsPort("LF TB PORT"))
        assert.is_true(checkWantsPort("wtb pot to org"))
        assert.is_true(checkWantsPort("need TB port"))

        -- assert.is_true(checkWantsPort("ORG"))
        -- assert.is_true(checkWantsPort("org brother"))
    end)

    it("returns false if the message doesn't contain a phrase that wants a port", function()
        assert.is_false(checkWantsPort("paladins unite"))
        assert.is_false(checkWantsPort("gfy"))
        assert.is_false(checkWantsPort("wts port"))
        assert.is_false(checkWantsPort("wts org"))
        assert.is_false(checkWantsPort("wts wtb port org"))
        assert.is_false(checkWantsPort("lf port org, wts item blah"))
        assert.is_false(checkWantsPort("lets go to org"))
        assert.is_false(checkWantsPort("lets go to tb"))
    end)
end)