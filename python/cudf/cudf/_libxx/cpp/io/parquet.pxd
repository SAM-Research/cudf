# Copyright (c) 2019-2020, NVIDIA CORPORATION.

from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp.map cimport map

from cudf._lib.cudf cimport *
from cudf._libxx.cpp.table.table_view cimport table_view


cdef extern from "cudf/cudf.h" namespace "cudf::io::parquet" nogil:

    cdef cppclass reader_options:
        vector[string] columns
        bool strings_to_categorical
        bool use_pandas_metadata
        gdf_time_unit timestamp_unit

        reader_options() except +

        reader_options(
            vector[string] columns,
            bool strings_as_category,
            bool use_pandas_metadata,
            gdf_time_unit timestamp_unit
        ) except +

    cdef cppclass reader:
        reader(
            string filepath,
            const reader_options &args
        ) except +

        reader(
            const char *buffer,
            size_t length,
            const reader_options &args
        ) except +

        string get_index_column() except +

        cudf_table read_all() except +

        cudf_table read_rows(size_t skip_rows, size_t num_rows) except +

        cudf_table read_row_group(size_t row_group) except +
