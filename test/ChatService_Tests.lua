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
    end)

    it("returns false if the message doesn't contain a phrase that wants a port", function()
        assert.is_false(checkWantsPort("paladins unite"))
        assert.is_false(checkWantsPort("gfy"))
        assert.is_false(checkWantsPort("wts port"))
    end)
end)