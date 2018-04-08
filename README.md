# ONNXS

[![Hex.pm](https://img.shields.io/hexpm/v/onnxs.svg)](https://hex.pm/packages/onnxs)
[![Build Status](https://travis-ci.org/jeffreyksmithjr/onnxs.svg?branch=master)](https://travis-ci.org/jeffreyksmithjr/onnxs)

_ONNXS_

_/ON-eks-ESS/_ 

_noun_

_1. ONNX interop for Elixir_

_2. The twenty-first century's yesterday_

## Overview

The [Open Neural Network eXchange format](https://onnx.ai/)(ONNX) is an open format for representing deep learning models.
Because it's an open format [supported by various deep learning frameworks](https://onnx.ai/supported-tools), it enables greater interoperation between different toolchains.

ONNXS allows you to decode trained neural network models produced by deep learning frameworks, modify them, and encode them back into the standard ONNX format.

## Installation

The package can be installed by adding onnxs to your list of dependencies in mix.exs:

```
def deps do
  [
    {:onnxs, "~> 0.2.0"}
  ]
end
```

## Usage

ONNXS allows you to decode saved ONNX models into Elixir structs.

```
iex(1)> {:ok, mnist_data} = File.read "./test/examples/mnist.onnx" 
{:ok,
 <<8, 3, 18, 4, 67, 78, 84, 75, 26, 3, 50, 46, 52, 40, 1, 58, 227, 206, 1, 10,
   199, 80, 18, 12, 80, 97, 114, 97, 109, 101, 116, 101, 114, 49, 57, 51, 26,
   12, 80, 97, 114, 97, 109, 101, 116, 101, 114, 49, ...>>}                 
iex(2)> mnist_struct = Onnx.ModelProto.decode(mnist_data)
%Onnx.ModelProto{
  doc_string: nil,
  domain: nil,
  graph: %Onnx.GraphProto{
    doc_string: nil,
    initializer: [],
    input: [
      %Onnx.ValueInfoProto{
        doc_string: nil,
        name: "Input3",
        type: %Onnx.TypeProto{ 
          value: {:tensor_type,
           %Onnx.TypeProto.Tensor{
             elem_type: 1,
             shape: %Onnx.TensorShapeProto
...
  ir_version: 3,
  metadata_props: [],
  model_version: 1,
  opset_import: [%Onnx.OperatorSetIdProto{domain: "", version: 1}],
  producer_name: "CNTK",
  producer_version: "2.4"
}
```

Once converted to structs, the models can be modified like any other Elixir struct.

```
iex(3)> mnist_updated = %{mnist_struct | model_version: 2}
```

Finally, ONNXS allows you define Elixir data as a struct that can be encoded to valid ONNX.

```
iex(4)> mnist_map = Map.from_struct(mnist_updated)        
%{
  doc_string: nil,
  domain: nil,
...
  model_version: 2,
  opset_import: [%Onnx.OperatorSetIdProto{domain: "", version: 1}],
  producer_name: "CNTK",
  producer_version: "2.4"
}
iex(5)> new_mnist_struct = Onnx.ModelProto.new(mnist_map)
%Onnx.ModelProto{
  doc_string: nil,
  domain: nil,
...
  producer_name: "CNTK",
  producer_version: "2.4"
}
iex(6)> encoded_mnist = Onnx.ModelProto.encode(new_mnist_struct)         
<<8, 3, 18, 4, 67, 78, 84, 75, 26, 3, 50, 46, 52, 40, 2, 58, 227, 206, 1, 10,
  199, 80, 18, 12, 80, 97, 114, 97, 109, 101, 116, 101, 114, 49, 57, 51, 26, 12,
  80, 97, 114, 97, 109, 101, 116, 101, 114, 49, 57, 51, ...>>
iex(7)> {:ok, file} = File.open "/tmp/mnist_v2.proto", [:write]
{:ok, #PID<0.229.0>}
iex(8)> IO.binwrite file, encoded_mnist
:ok
iex(9)> File.close file
:ok
```

## Implementation

This implementation uses [Bing Tony Han](https://github.com/tony612/protobuf-elixir)'s [protobuf-elixir](https://github.com/tony612/protobuf-elixir) library to generate Elixir code from the [ONNX proto file](https://github.com/onnx/onnx/blob/master/onnx/onnx.proto).
