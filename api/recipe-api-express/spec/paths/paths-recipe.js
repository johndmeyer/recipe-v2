export default function () {
    let operations = {
        GET,
        POST,
        PUT,
        DELETE
    };

    function GET(req, res, next) {}

    function POST(req, res, next) {}

    function PUT(req, res, next) {}

    function DELETE(req, res, next) {}

    GET.apiDoc = {
        summary: "Returns list of recipes",
        operationId: "getUsers",
        responses: {
            200: {
                description: "List of users",
                content: {
                    "application/json": {
                        schema: {
                            type: "array",
                            items: {
                                $ref: "#/components/schemas/User",
                            },
                        },
                    },
                },
            },
        },
    };

    PUT.apiDoc = {};

    DELETE.apiDoc = {};

    return operations;
}