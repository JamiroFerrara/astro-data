local Optional = require "mason-core.optional"
local Result = require "mason-core.result"
local spy = require "luassert.spy"

describe("Optional.of_nilable", function()
    it("should create empty optionals", function()
        local empty = Optional.empty()
        assert.is_false(empty:is_present())
    end)

    it("should create non-empty optionals", function()
        local empty = Optional.of_nilable "value"
        assert.is_true(empty:is_present())
    end)

    it("should use memoized empty value", function()
        assert.is_true(Optional.empty() == Optional.empty())
    end)
end)

describe("Optional.get()", function()
    it("should map non-empty values", function()
        local str = Optional.of_nilable("world!")
            :map(function(val)
                return "Hello " .. val
            end)
            :get()
        assert.equals("Hello world!", str)
    end)

    it("should raise error when getting empty value", function()
        local err = assert.has_error(function()
            Optional.empty():get()
        end)
        assert.equals("No value present.", err)
    end)
end)

describe("Optional.or_else()", function()
    it("should use .or_else() value if empty", function()
        local value = Optional.empty():or_else "Hello!"
        assert.equals("Hello!", value)
    end)

    it("should not use .or_else() value if not empty", function()
        local value = Optional.of_nilable("Good bye!"):or_else "Hello!"
        assert.equals("Good bye!", value)
    end)
end)

describe("Optional.if_present()", function()
    it("should not call .if_present() if value is empty", function()
        local present = spy.new()
        Optional.empty():if_present(present)
        assert.spy(present).was_not_called()
    end)

    it("should call .if_present() if value is not empty", function()
        local present = spy.new()
        Optional.of_nilable("value"):if_present(present)
        assert.spy(present).was_called(1)
        assert.spy(present).was_called_with "value"
    end)
end)

describe("Optional.if_not_present()", function()
    it("should not call .if_not_present() if value is not empty", function()
        local present = spy.new()
        Optional.of_nilable("value"):if_not_present(present)
        assert.spy(present).was_not_called()
    end)

    it("should call .if_not_present() if value is empty", function()
        local present = spy.new()
        Optional.empty():if_not_present(present)
        assert.spy(present).was_called(1)
    end)
end)

describe("Optional.ok_or()", function()
    it("should return success variant if non-empty", function()
        local result = Optional.of_nilable("Hello world!"):ok_or()
        assert.is_true(getmetatable(result) == Result)
        assert.equals("Hello world!", result:get_or_nil())
    end)

    it("should return failure variant if empty", function()
        local result = Optional.empty():ok_or(function()
            return "I'm empty."
        end)
        assert.is_true(getmetatable(result) == Result)
        assert.equals("I'm empty.", result:err_or_nil())
    end)
end)
