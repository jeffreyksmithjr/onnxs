defmodule Onnx.AttributeProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          doc_string: String.t(),
          type: integer,
          f: float,
          i: integer,
          s: String.t(),
          t: Onnx.TensorProto.t(),
          g: Onnx.GraphProto.t(),
          floats: [float],
          ints: [integer],
          strings: [String.t()],
          tensors: [Onnx.TensorProto.t()],
          graphs: [Onnx.GraphProto.t()]
        }
  defstruct [
    :name,
    :doc_string,
    :type,
    :f,
    :i,
    :s,
    :t,
    :g,
    :floats,
    :ints,
    :strings,
    :tensors,
    :graphs
  ]

  field(:name, 1, optional: true, type: :string)
  field(:doc_string, 13, optional: true, type: :string)
  field(:type, 20, optional: true, type: Onnx.AttributeProto.AttributeType, enum: true)
  field(:f, 2, optional: true, type: :float)
  field(:i, 3, optional: true, type: :int64)
  field(:s, 4, optional: true, type: :bytes)
  field(:t, 5, optional: true, type: Onnx.TensorProto)
  field(:g, 6, optional: true, type: Onnx.GraphProto)
  field(:floats, 7, repeated: true, type: :float)
  field(:ints, 8, repeated: true, type: :int64)
  field(:strings, 9, repeated: true, type: :bytes)
  field(:tensors, 10, repeated: true, type: Onnx.TensorProto)
  field(:graphs, 11, repeated: true, type: Onnx.GraphProto)
end

defmodule Onnx.AttributeProto.AttributeType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field(:UNDEFINED, 0)
  field(:FLOAT, 1)
  field(:INT, 2)
  field(:STRING, 3)
  field(:TENSOR, 4)
  field(:GRAPH, 5)
  field(:FLOATS, 6)
  field(:INTS, 7)
  field(:STRINGS, 8)
  field(:TENSORS, 9)
  field(:GRAPHS, 10)
end

defmodule Onnx.ValueInfoProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          name: String.t(),
          type: Onnx.TypeProto.t(),
          doc_string: String.t()
        }
  defstruct [:name, :type, :doc_string]

  field(:name, 1, optional: true, type: :string)
  field(:type, 2, optional: true, type: Onnx.TypeProto)
  field(:doc_string, 3, optional: true, type: :string)
end

defmodule Onnx.NodeProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          input: [String.t()],
          output: [String.t()],
          name: String.t(),
          op_type: String.t(),
          domain: String.t(),
          attribute: [Onnx.AttributeProto.t()],
          doc_string: String.t()
        }
  defstruct [:input, :output, :name, :op_type, :domain, :attribute, :doc_string]

  field(:input, 1, repeated: true, type: :string)
  field(:output, 2, repeated: true, type: :string)
  field(:name, 3, optional: true, type: :string)
  field(:op_type, 4, optional: true, type: :string)
  field(:domain, 7, optional: true, type: :string)
  field(:attribute, 5, repeated: true, type: Onnx.AttributeProto)
  field(:doc_string, 6, optional: true, type: :string)
end

defmodule Onnx.ModelProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          ir_version: integer,
          opset_import: [Onnx.OperatorSetIdProto.t()],
          producer_name: String.t(),
          producer_version: String.t(),
          domain: String.t(),
          model_version: integer,
          doc_string: String.t(),
          graph: Onnx.GraphProto.t(),
          metadata_props: [Onnx.StringStringEntryProto.t()]
        }
  defstruct [
    :ir_version,
    :opset_import,
    :producer_name,
    :producer_version,
    :domain,
    :model_version,
    :doc_string,
    :graph,
    :metadata_props
  ]

  field(:ir_version, 1, optional: true, type: :int64)
  field(:opset_import, 8, repeated: true, type: Onnx.OperatorSetIdProto)
  field(:producer_name, 2, optional: true, type: :string)
  field(:producer_version, 3, optional: true, type: :string)
  field(:domain, 4, optional: true, type: :string)
  field(:model_version, 5, optional: true, type: :int64)
  field(:doc_string, 6, optional: true, type: :string)
  field(:graph, 7, optional: true, type: Onnx.GraphProto)
  field(:metadata_props, 14, repeated: true, type: Onnx.StringStringEntryProto)
end

defmodule Onnx.StringStringEntryProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field(:key, 1, optional: true, type: :string)
  field(:value, 2, optional: true, type: :string)
end

defmodule Onnx.GraphProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          node: [Onnx.NodeProto.t()],
          name: String.t(),
          initializer: [Onnx.TensorProto.t()],
          doc_string: String.t(),
          input: [Onnx.ValueInfoProto.t()],
          output: [Onnx.ValueInfoProto.t()],
          value_info: [Onnx.ValueInfoProto.t()]
        }
  defstruct [:node, :name, :initializer, :doc_string, :input, :output, :value_info]

  field(:node, 1, repeated: true, type: Onnx.NodeProto)
  field(:name, 2, optional: true, type: :string)
  field(:initializer, 5, repeated: true, type: Onnx.TensorProto)
  field(:doc_string, 10, optional: true, type: :string)
  field(:input, 11, repeated: true, type: Onnx.ValueInfoProto)
  field(:output, 12, repeated: true, type: Onnx.ValueInfoProto)
  field(:value_info, 13, repeated: true, type: Onnx.ValueInfoProto)
end

defmodule Onnx.TensorProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          dims: [integer],
          data_type: integer,
          segment: Onnx.TensorProto.Segment.t(),
          float_data: [float],
          int32_data: [integer],
          string_data: [String.t()],
          int64_data: [integer],
          name: String.t(),
          doc_string: String.t(),
          raw_data: String.t(),
          double_data: [float],
          uint64_data: [non_neg_integer]
        }
  defstruct [
    :dims,
    :data_type,
    :segment,
    :float_data,
    :int32_data,
    :string_data,
    :int64_data,
    :name,
    :doc_string,
    :raw_data,
    :double_data,
    :uint64_data
  ]

  field(:dims, 1, repeated: true, type: :int64)
  field(:data_type, 2, optional: true, type: Onnx.TensorProto.DataType, enum: true)
  field(:segment, 3, optional: true, type: Onnx.TensorProto.Segment)
  field(:float_data, 4, repeated: true, type: :float, packed: true)
  field(:int32_data, 5, repeated: true, type: :int32, packed: true)
  field(:string_data, 6, repeated: true, type: :bytes)
  field(:int64_data, 7, repeated: true, type: :int64, packed: true)
  field(:name, 8, optional: true, type: :string)
  field(:doc_string, 12, optional: true, type: :string)
  field(:raw_data, 9, optional: true, type: :bytes)
  field(:double_data, 10, repeated: true, type: :double, packed: true)
  field(:uint64_data, 11, repeated: true, type: :uint64, packed: true)
end

defmodule Onnx.TensorProto.Segment do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          begin: integer,
          end: integer
        }
  defstruct [:begin, :end]

  field(:begin, 1, optional: true, type: :int64)
  field(:end, 2, optional: true, type: :int64)
end

defmodule Onnx.TensorProto.DataType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field(:UNDEFINED, 0)
  field(:FLOAT, 1)
  field(:UINT8, 2)
  field(:INT8, 3)
  field(:UINT16, 4)
  field(:INT16, 5)
  field(:INT32, 6)
  field(:INT64, 7)
  field(:STRING, 8)
  field(:BOOL, 9)
  field(:FLOAT16, 10)
  field(:DOUBLE, 11)
  field(:UINT32, 12)
  field(:UINT64, 13)
  field(:COMPLEX64, 14)
  field(:COMPLEX128, 15)
end

defmodule Onnx.TensorShapeProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          dim: [Onnx.TensorShapeProto.Dimension.t()]
        }
  defstruct [:dim]

  field(:dim, 1, repeated: true, type: Onnx.TensorShapeProto.Dimension)
end

defmodule Onnx.TensorShapeProto.Dimension do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof(:value, 0)
  field(:dim_value, 1, optional: true, type: :int64, oneof: 0)
  field(:dim_param, 2, optional: true, type: :string, oneof: 0)
end

defmodule Onnx.TypeProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof(:value, 0)
  field(:tensor_type, 1, optional: true, type: Onnx.TypeProto.Tensor, oneof: 0)
end

defmodule Onnx.TypeProto.Tensor do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          elem_type: integer,
          shape: Onnx.TensorShapeProto.t()
        }
  defstruct [:elem_type, :shape]

  field(:elem_type, 1, optional: true, type: Onnx.TensorProto.DataType, enum: true)
  field(:shape, 2, optional: true, type: Onnx.TensorShapeProto)
end

defmodule Onnx.OperatorSetIdProto do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          domain: String.t(),
          version: integer
        }
  defstruct [:domain, :version]

  field(:domain, 1, optional: true, type: :string)
  field(:version, 2, optional: true, type: :int64)
end

defmodule Onnx.Version do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  field(:_START_VERSION, 0)
  field(:IR_VERSION_2017_10_10, 1)
  field(:IR_VERSION_2017_10_30, 2)
  field(:IR_VERSION, 3)
end
