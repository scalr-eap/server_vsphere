package terraform

test_allowed {
    result = deny with input as data.mock.allowed
    count(result) == 0
}