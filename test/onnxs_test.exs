defmodule ONNXSTest do
  use ExUnit.Case
  doctest ONNXS

  test "round trip conversion doesn't change data" do
    {:ok, mnist_data} = File.read "./test/examples/mnist.onnx" 
    mnist_struct = Onnx.ModelProto.decode(mnist_data)
    encoded_mnist = Onnx.ModelProto.encode(mnist_struct)
    redecoded_mnist = Onnx.ModelProto.decode(encoded_mnist)
    assert mnist_struct == redecoded_mnist
  end
end
