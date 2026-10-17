# Library Database SQL

A beginner-friendly Microsoft SQL Server / T-SQL exercise that creates a small library database, loads sample categories and books, updates and deletes records, and demonstrates basic schema changes.

## Project overview

This project is based on an SQL fundamentals exercise. The script is intentionally focused on core database-definition and data-manipulation operations rather than a full library-management application. It does not add users, loans, members, authentication, stored procedures, views, or application code.

The main script is [`library_database.sql`](library_database.sql).

> **Screenshot placeholder — no image included**
>
> Add a project screenshot here later, for example an SSMS view showing the `Books` and `Categories` tables. This placeholder is intentionally left empty at the request of the project owner.

## Database schema

The script creates a database named `LibraryDB` containing two tables:

### `Categories`

| Column | Type | Definition |
| --- | --- | --- |
| `CategoryID` | `INT` | Identity primary key |
| `CategoryName` | `NVARCHAR(50)` | Required and unique category name |
| `Description` | `NVARCHAR(150)` | Optional category description |
| `FloorNumber` | `INT` | Added later with `ALTER TABLE` |

### `Books`

| Column | Type | Definition |
| --- | --- | --- |
| `BookID` | `INT` | Identity primary key |
| `CategoryID` | `INT` | Required foreign key to `Categories.CategoryID` |
| `Title` | `NVARCHAR(100)` | Required book title |
| `AuthorName` | `NVARCHAR(60)` | Required author name |
| `Price` | `DECIMAL(14,2)` | Required; must be greater than zero |
| `PublishDate` | `DATE` | Optional publication date |
| `Quantity` | `INT` | Required; must be zero or greater |
| `IsAvailable` | `BIT` | Defaults to `1` when omitted |
| `ISBN` | `NVARCHAR(20)` | Added later with `ALTER TABLE` |
| `Publisher` | `NVARCHAR(100)` | Added as `NVARCHAR(60)`, then widened |

## Relationship

`Categories` and `Books` have a one-to-many relationship:

- One category can be associated with many books.
- Each book must reference an existing category through `Books.CategoryID`.
- The foreign key constraint is named `category_id_fk`.

The script inserts four categories and eight books. It then moves `C# Fundamentals` to category `4`, so the final sample data reflects the updates in the exercise.

## Requirements

- Microsoft SQL Server, with permission to create a database.
- SQL Server Management Studio (SSMS), Azure Data Studio, or another client that supports T-SQL.
- A query runner that supports the SQL Server batch separator `GO`.

`GO` is a client-side batch separator used by tools such as SSMS and `sqlcmd`; it is not a Transact-SQL statement understood by the SQL Server engine itself. If another SQL client does not recognize `GO`, run the batches separately or configure the client for SQL Server batch separators.

## Setup and execution

1. Open [`library_database.sql`](library_database.sql) in SSMS, Azure Data Studio, or `sqlcmd`.
2. Connect to the target SQL Server instance using an account authorized to create databases.
3. Review the script before execution. It contains sample `UPDATE` and `DELETE` statements and is designed for a fresh setup.
4. Execute the complete script. The script creates `LibraryDB`, switches to it, creates the tables, inserts sample data, performs the requested updates and deletes, and applies the schema changes.
5. Refresh the database list and inspect `LibraryDB`, `dbo.Categories`, and `dbo.Books`.

### Example command-line execution

With the SQL Server command-line utility installed, a typical command is:

```bash
sqlcmd -S <server-name> -E -i library_database.sql
```

Use the authentication and connection options appropriate for your SQL Server environment. No credentials are included in this repository.

## SQL concepts demonstrated

The script contains examples of the following concepts:

- Database creation and selection with `CREATE DATABASE` and `USE`.
- Batch separation with `GO`.
- Table creation with `CREATE TABLE`.
- Identity columns using `IDENTITY(1, 1)`.
- Primary keys and a named foreign key.
- Required and optional columns with `NOT NULL` and `NULL`.
- A unique constraint on `CategoryName`.
- A default value for `IsAvailable`.
- Validation rules with `CHECK` constraints for price and quantity.
- Multi-row inserts with explicit column lists.
- Unicode string literals using the `N'...'` notation.
- Record updates with `UPDATE`, `SET`, and `WHERE`.
- Arithmetic updates such as `Price = Price + 100`.
- Record deletion with `DELETE` and `WHERE`.
- Schema changes with `ALTER TABLE ... ADD`.
- Column type/length changes with `ALTER TABLE ... ALTER COLUMN`.
- Date, decimal, integer, bit, and Unicode character data types.

## Example queries from the script

Update one matching row:

```sql
UPDATE Books
SET Price = 500
WHERE Title = N'Python Basics';
```

Apply an arithmetic update to a category:

```sql
UPDATE Books
SET Price = Price + 100
WHERE CategoryID = 2;
```

Delete a matching record:

```sql
DELETE FROM Books
WHERE Title = N'Network Security';
```

Add a column and then widen its type:

```sql
ALTER TABLE Books
ADD Publisher NVARCHAR(60);

ALTER TABLE Books
ALTER COLUMN Publisher NVARCHAR(100);
```

## Validation and limitations

The script was reviewed and cleaned as SQL Server / T-SQL. The cleanup preserves the exercise's intended operations and data sequence while adding explicit insert column names, consistent Unicode literals, clearer formatting, and a rerun warning.

This environment does not include a running SQL Server instance, so execution against a live SQL Server engine could not be performed here. Validation was therefore limited to static review of T-SQL structure, statement ordering, constraints, object references, and batch boundaries. Run it in a test SQL Server database before using it in any other environment.

The script is intentionally **not idempotent**: running it again without resetting `LibraryDB` will fail when objects or data already exist. The `UPDATE` and `DELETE` statements are part of the original exercise and are not wrapped in a transaction or rollback block.

## Repository contents

```text
.
├── .gitignore
├── README.md
└── library_database.sql
```
