package model 

import (
	"encoding/json"
	"fmt"
	"io"

	"github.com/99designs/gqlgen/graphql"
	"github.com/lib/pq"
)

// MarshalStringArray marshals model.StringArray to a JSON array of strings
func MarshalStringArray(sa pq.StringArray) graphql.Marshaler {
	return graphql.WriterFunc(func(w io.Writer) {
		// Convert model.StringArray to []string and marshal to JSON
		err := json.NewEncoder(w).Encode([]string(sa))
		if err != nil {
			// Fallback to empty array if encoding fails
			w.Write([]byte("[]"))
		}
	})
}

// UnmarshalStringArray unmarshals GraphQL input to model.StringArray
func UnmarshalStringArray(v any) (pq.StringArray, error) {
	switch v := v.(type) {
	case []any:
		// Convert []interface{} to []string
		result := make([]string, len(v))
		for i, val := range v {
			str, ok := val.(string)
			if !ok {
				return nil, fmt.Errorf("element %d is not a string: %T", i, val)
			}
			result[i] = str
		}
		return pq.StringArray(result), nil
	case []string:
		// Directly convert []string to model.StringArray
		return pq.StringArray(v), nil
	case nil:
		// Handle null input
		return nil, nil
	default:
		return nil, fmt.Errorf("%T is not a valid StringArray", v)
	}
}
